<template>
  <el-breadcrumb class="fluent-breadcrumb" separator="/">
    <el-breadcrumb-item v-for="item in breadcrumbList" :key="item.name" :to="{ path: item.path, query: item.query }">
      {{ item.name }}
    </el-breadcrumb-item>
  </el-breadcrumb>

  <div class="fluent-container">
    <div class="fluent-handle-box">
      <el-button @click="deleteAll" class="fluent-btn fluent-btn-secondary">批量删除</el-button>
      <el-input placeholder="筛选歌曲" v-model="searchWord" class="fluent-input"></el-input>
    </div>
    <el-table 
      class="fluent-table"
      border 
      size="small" 
      :data="data" 
      @selection-change="handleSelectionChange"
      :header-cell-style="{backgroundColor: 'var(--fluent-background)', color: 'var(--fluent-text-primary)'}">
      <el-table-column type="selection" width="40" align="center"></el-table-column>
      <el-table-column prop="name" label="歌曲"></el-table-column>
      <el-table-column label="操作" width="90" align="center">
        <template v-slot="scope">
          <el-button type="danger" @click="deleteRow(scope.row.id)" size="small">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      class="fluent-pagination"
      background
      layout="total, sizes, prev, pager, next, jumper"
      :current-page="currentPage"
      :page-size="pageSize"
      :page-sizes="[10, 20, 30, 50]"
      :total="tableData.length"
      @current-change="handleCurrentChange"
      @size-change="handleSizeChange"
    >
    </el-pagination>
  </div>

  <!-- 删除提示框 -->
  <del-dialog :delVisible="delVisible" @confirm="confirm" @cancelRow="delVisible = $event"></del-dialog>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, watch, ref, computed } from "vue";
import { useStore } from "vuex";
import { HttpManager } from "@/api";
import DelDialog from "@/components/dialog/DelDialog.vue";

interface ResponseBody {
  code: string;
  success: boolean;
  message: string;
  type: string;
}

export default defineComponent({
  components: {
    DelDialog,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();

    const tableData = ref([]); // 记录歌曲，用于显示
    const tempDate = ref([]); // 记录歌曲，用于搜索时能临时记录一份歌曲列表
    const pageSize = ref(10); // 页数
    const currentPage = ref(1); // 当前页
    const breadcrumbList = computed(() => store.getters.breadcrumbList);

    // 计算当前表格中的数据
    const data = computed(() => {
      return tableData.value.slice((currentPage.value - 1) * pageSize.value, currentPage.value * pageSize.value);
    });

    const searchWord = ref(""); // 记录输入框输入的内容
    watch(searchWord, () => {
      if (searchWord.value === "") {
        tableData.value = tempDate.value;
      } else {
        tableData.value = [];
        for (let item of tempDate.value) {
          if (item.name.includes(searchWord.value)) {
            tableData.value.push(item);
          }
        }
      }
    });

    getData();

    // 通过用户 ID 获取用户收藏的歌曲 ID
    async function getData() {
      tableData.value = [];
      tempDate.value = [];
      const result = (await HttpManager.getCollectionOfUser(proxy.$route.query.id)) as any;
      for (let item of result.data) {
        const result = await HttpManager.getSongOfId(item.songId) as any;
        tableData.value.push(result.data[0]);
        tempDate.value.push(result.data[0]);
      }
    }

    // 获取当前页
    function handleCurrentChange(val) {
      currentPage.value = val;
    }
    
    function handleSizeChange(val) {
      pageSize.value = val;
    }

    /**
     * 删除
     */
    const idx = ref(-1); // 记录当前要删除的行
    const multipleSelection = ref([]); // 记录当前要删除的列表
    const delVisible = ref(false); // 显示删除框

    async function confirm() {
      const result = (await HttpManager.deleteCollection(proxy.$route.query.id, idx.value)) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
      });

      if (result.success) getData();
      delVisible.value = false;
    }
    function deleteRow(id) {
      idx.value = id;
      delVisible.value = true;
    }
    function handleSelectionChange(val) {
      multipleSelection.value = val;
    }
    function deleteAll() {
      for (let item of multipleSelection.value) {
        deleteRow(item.id);
        confirm();
      }
      multipleSelection.value = [];
    }

    return {
      searchWord,
      data,
      tableData,
      delVisible,
      pageSize,
      currentPage,
      breadcrumbList,
      deleteAll,
      handleSelectionChange,
      handleCurrentChange,
      handleSizeChange,
      deleteRow,
      confirm,
    };
  },
});
</script>

<style scoped>
.fluent-breadcrumb {
  margin-bottom: 20px;
  padding: 10px;
  background-color: var(--fluent-background);
  border-radius: 4px;
  box-shadow: var(--fluent-box-shadow);
}
</style>
