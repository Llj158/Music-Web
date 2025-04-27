<template>
  <el-breadcrumb class="fluent-breadcrumb" separator="/">
    <el-breadcrumb-item v-for="item in breadcrumbList" :key="item.name" :to="{ path: item.path, query: item.query }">
      {{ item.name }}
    </el-breadcrumb-item>
  </el-breadcrumb>

  <div class="fluent-container">
    <div class="fluent-handle-box">
      <el-button @click="deleteAll" class="fluent-btn fluent-btn-secondary">批量删除</el-button>
      <el-input v-model="searchWord" placeholder="筛选关键词" class="fluent-input"></el-input>
    </div>
    <el-table 
      class="fluent-table"
      border 
      size="small" 
      :data="tableData" 
      @selection-change="handleSelectionChange"
      :header-cell-style="{backgroundColor: 'var(--fluent-background)', color: 'var(--fluent-text-primary)'}">
      <el-table-column type="selection" width="40" align="center"></el-table-column>
      <el-table-column prop="id" label="ID" width="50" align="center"></el-table-column>
      <el-table-column prop="username" label="用户" width="80" align="center"></el-table-column>
      <el-table-column prop="content" label="评论内容"></el-table-column>
      <el-table-column label="操作" width="100" align="center">
        <template v-slot="scope">
          <el-button type="danger" @click="deleteRow(scope.row.id)" size="small" class="fluent-btn-danger">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-pagination
      class="fluent-pagination"
      background
      layout="total, sizes, prev, pager, next, jumper"
      :current-page="1"
      :page-size="10"
      :page-sizes="[10, 20, 30, 50]"
      :total="tableData.length"
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

export default defineComponent({
  components: {
    DelDialog,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();

    const tableData = ref([]); // 记录歌曲，用于显示
    const tempDate = ref([]); // 记录歌曲，用于搜索时能临时记录一份歌曲列表
    const breadcrumbList = computed(() => store.getters.breadcrumbList);

    const searchWord = ref(""); // 记录输入框输入的内容
    watch(searchWord, () => {
      if (searchWord.value === "") {
        tableData.value = tempDate.value;
      } else {
        tableData.value = [];
        for (let item of tempDate.value) {
          if (item.username.includes(searchWord.value)) {
            tableData.value.push(item);
          }
        }
      }
    });

    getData();

    // 获取评论
    function getData() {
      tableData.value = [];
      tempDate.value = [];
      let promise = null;
      if (proxy.$route.query.type == "0") {
        promise = HttpManager.getCommentOfSongId(proxy.$route.query.id);
      } else if (proxy.$route.query.type == "1") {
        promise = HttpManager.getCommentOfSongListId(proxy.$route.query.id);
      }

      promise.then((res) => {
        for (let item of (res as ResponseBody).data) {
          getUsers(item.userId, item);
        }
      });
    }
    async function getUsers(id, item) {
      const result = (await HttpManager.getUserOfId(id)) as ResponseBody;
      item.username = result.data[0].username;
      tableData.value.push(item);
      tempDate.value.push(item);
    }

    /**
     * 删除
     */
    const idx = ref(-1); // 记录当前要删除的行
    const multipleSelection = ref([]); // 记录当前要删除的列表
    const delVisible = ref(false); // 显示删除框
    const isBatchDelete = ref(false);

    function handleSelectionChange(val) {
      multipleSelection.value = val;
    }
    
    function deleteAll() {
      if (multipleSelection.value.length === 0) {
        (proxy as any).$message.warning('请至少选择一项进行删除');
        return;
      }
      
      delVisible.value = true;
      // 设置一个特殊标记，表示这是批量删除操作
      isBatchDelete.value = true;
    }
    
    async function confirm() {
      if (isBatchDelete.value) {
        // 批量删除操作
        for (let item of multipleSelection.value) {
          try {
            const result = (await HttpManager.deleteComment(item.id)) as ResponseBody;
            if (!result.success) {
              (proxy as any).$message.error(`删除评论失败: ${result.message}`);
            }
          } catch (error) {
            console.error('删除评论失败:', error);
            (proxy as any).$message.error('删除评论时发生错误');
          }
        }
        
        (proxy as any).$message.success(`成功删除 ${multipleSelection.value.length} 条评论`);
        multipleSelection.value = [];
        isBatchDelete.value = false;
        getData();
      } else {
        // 单个删除操作
        const result = (await HttpManager.deleteComment(idx.value)) as ResponseBody;
        (proxy as any).$message({
          message: result.message,
          type: result.type,
        });
        if (result.success) getData();
      }
      delVisible.value = false;
    }
    function deleteRow(id) {
      idx.value = id;
      delVisible.value = true;
    }

    return {
      searchWord,
      tableData,
      delVisible,
      breadcrumbList,
      deleteAll,
      handleSelectionChange,
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

.fluent-container {
  padding: 10px;
}

.fluent-handle-box {
  margin-bottom: 20px;
  display: flex;
  align-items: center;
  gap: 10px;
}

.fluent-table {
  width: 100%;
  background-color: var(--fluent-background);
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0,0,0,0.1);
  table-layout: fixed;
}

.fluent-input {
  width: 100%;
}

.fluent-btn {
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}

.fluent-btn-secondary {
  background-color: var(--fluent-secondary);
  color: var(--fluent-text-on-secondary);
}

.fluent-btn-danger {
  background-color: #f56c6c;
  color: #fff;
}

.fluent-pagination {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

:deep(.el-table) {
  border-radius: 8px;
  margin-top: 10px;
}

:deep(.el-table__header) {
  font-weight: bold;
}

:deep(.el-table__body-wrapper) {
  overflow-x: hidden !important;
}

:deep(.el-table__header-wrapper) {
  overflow-x: hidden !important;
}
</style>
