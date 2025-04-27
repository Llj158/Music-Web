<template>
  <div class="fluent-container">
    <div class="fluent-handle-box">
      <el-button @click="deleteAll" class="fluent-btn fluent-btn-secondary">批量删除</el-button>
      <el-input v-model="searchWord" placeholder="筛选用户" class="fluent-input"></el-input>
    </div>

    <el-table 
      class="fluent-table"
      border 
      size="small" 
      :data="data" 
      @selection-change="handleSelectionChange"
      :header-cell-style="{backgroundColor: 'var(--fluent-background)', color: 'var(--fluent-text-primary)'}"
      @sort-change="handleSortChange">
      <el-table-column type="selection" width="40" align="center"></el-table-column>
    
      <el-table-column label="用户头像" width="120" align="center">
        <template v-slot="scope">
          <div class="user-avatar">
            <img :src="attachImageUrl(scope.row.avator)" class="fluent-table-img" />
          </div>
          <el-upload
            :http-request="(file) => customUpload(file, scope.row.id)"
            :show-file-list="false"
            :before-upload="beforeAvatarUpload">
            <el-button size="small">更新头像</el-button>
          </el-upload>
        </template>
      </el-table-column>
      <el-table-column prop="username" label="用户名" sortable="custom"></el-table-column>
      <el-table-column label="性别" width="50" align="center">
        <template v-slot="scope">
          <div>{{ changeSex(scope.row.sex, 'user') }}</div>
        </template>
      </el-table-column>
      <el-table-column label="手机号码" prop="phoneNum" width="120" align="center"></el-table-column>
      <el-table-column label="邮箱" prop="email" width="120" align="center"></el-table-column>
      <el-table-column label="生日" width="120" align="center">
        <template v-slot="scope">
          <div>{{ getBirth(scope.row.birth) }}</div>
        </template>
      </el-table-column>
      <el-table-column label="签名" prop="introduction">
        <template v-slot="scope">
          <p style="padding: 5px;">
            {{ scope.row.introduction }}
          </p>
        </template>
      </el-table-column>
      <el-table-column label="地区" prop="location" width="70" align="center"></el-table-column>
      <el-table-column label="收藏" width="90" align="center">
        <template v-slot="scope">
          <el-button @click="goCollectPage(scope.row.id)" size="small" type="primary">收藏</el-button>
        </template>
      </el-table-column>
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
      :page-sizes="[4, 8, 12, 16]"
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
import { defineComponent, getCurrentInstance, watch, ref, reactive, computed } from "vue";
import mixin from "@/mixins/mixin";
import { HttpManager } from "@/api";
import { RouterName } from "@/enums";
import DelDialog from "@/components/dialog/DelDialog.vue";
import { getBirth } from "@/utils";

interface UploadResponse {
  success: boolean;
  message: string;
  type: string;
  data: string;
}

export default defineComponent({
  components: {
    DelDialog,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const { changeSex, routerManager } = mixin();

    const tableData = ref([]); // 记录歌曲，用于显示
    const tempDate = ref([]); // 记录歌曲，用于搜索时能临时记录一份歌曲列表
    const originalData = ref([]); // 保存原始顺序
    const currentSort = ref({ prop: '', order: '' });
    const pageSize = ref(4); // 页数
    const currentPage = ref(1); // 当前页

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
          if (item.username.includes(searchWord.value)) {
            tableData.value.push(item);
          }
        }
      }
    });

    // 处理排序变化
    function handleSortChange(sort: { prop: string; order: string }) {
      currentSort.value = sort;
      if (!sort.prop) {
        // 恢复原始顺序
        tableData.value = [...originalData.value];
        return;
      }

      const sortedList = [...tableData.value];
      sortedList.sort((a, b) => {
        let valueA = (a[sort.prop] || '').toLowerCase();
        let valueB = (b[sort.prop] || '').toLowerCase();

        if (sort.order === 'ascending') {
          return valueA.localeCompare(valueB);
        } else {
          return valueB.localeCompare(valueA);
        }
      });

      tableData.value = sortedList;
    }

    getData();

    // 获取用户信息
    async function getData() {
      tableData.value = [];
      tempDate.value = [];
      const result = (await HttpManager.getAllUser()) as ResponseBody;
      tableData.value = result.data;
      tempDate.value = result.data;
      originalData.value = [...result.data]; // 保存原始顺序
      currentPage.value = 1;
    }
    // 获取当前页
    function handleCurrentChange(val) {
      currentPage.value = val;
    }
    
    function handleSizeChange(val) {
      pageSize.value = val;
    }

    /**
     * 路由
     */
    function goCollectPage(id) {
      const breadcrumbList = reactive([
        {
          path: RouterName.Consumer,
          name: "用户管理",
        },
        {
          path: "",
          name: "收藏信息",
        },
      ]);
      proxy.$store.commit("setBreadcrumbList", breadcrumbList);
      routerManager(RouterName.Collect, { path: RouterName.Collect, query: { id } });
    }

    /**
     * 删除
     */
    const idx = ref(-1); // 记录当前要删除的行
    const multipleSelection = ref([]); // 记录当前要删除的列表
    const delVisible = ref(false); // 显示删除框

    async function confirm() {
      const result = (await HttpManager.deleteUser(idx.value)) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
      });
      if (result) getData();
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
      if (multipleSelection.value.length === 0) {
        (proxy as any).$message({
          message: '请至少选择一项进行删除',
          type: 'warning'
        });
        return;
      }
      
      (proxy as any).$confirm('确定要删除所选用户吗？此操作不可恢复', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(async () => {
        // 用户确认后执行批量删除
        const promises = [];
        for (let item of multipleSelection.value) {
          const result = HttpManager.deleteUser(item.id);
          promises.push(result);
        }
        
        try {
          await Promise.all(promises);
          (proxy as any).$message({
            message: '批量删除成功',
            type: 'success'
          });
          getData(); // 刷新数据
        } catch (error) {
          (proxy as any).$message.error('删除过程中发生错误');
        }
        
      multipleSelection.value = [];
      }).catch(() => {
        // 用户取消删除操作
        (proxy as any).$message({
          type: 'info',
          message: '已取消删除'
        });
      });
    }

    async function customUpload({ file }, userId) {
      const formData = new FormData();
      formData.append('file', file);
      formData.append('id', userId);
      try {
        const response = await HttpManager.updateUserAvatar(formData) as UploadResponse;
        if (response && response.success) {
          (proxy as any).$message({
            message: response.message || '上传成功',
            type: response.type || 'success'
          });
          getData(); // 刷新用户列表
        } else {
          throw new Error(response?.message || '上传失败');
        }
      } catch (error: any) {
        (proxy as any).$message.error(error.message || '上传失败');
      }
    }

    function beforeAvatarUpload(file) {
      const isJPG = file.type === 'image/jpeg' || file.type === 'image/png' || file.type === 'image/gif';
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        (proxy as any).$message.error('上传头像图片只能是 JPG/PNG/GIF 格式!');
        return false;
      }
      if (!isLt2M) {
        (proxy as any).$message.error('上传头像图片大小不能超过 2MB!');
        return false;
      }
      return true;
    }

    return {
      searchWord,
      data,
      tableData,
      delVisible,
      pageSize,
      currentPage,
      deleteAll,
      handleSelectionChange,
      handleCurrentChange,
      handleSizeChange,
      changeSex,
      getBirth,
      deleteRow,
      customUpload,
      beforeAvatarUpload,
      confirm,
      goCollectPage,
      attachImageUrl: HttpManager.attachImageUrl,
      handleSortChange,
    };
  },
});
</script>

<style scoped>
.user-avatar {
  width: 100%;
  height: 80px;
  border-radius: 5px;
  margin-bottom: 5px;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
}

.fluent-table-img {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 4px;
  transition: var(--fluent-transition);
}

.fluent-table-img:hover {
  transform: scale(1.05);
  box-shadow: var(--fluent-box-shadow-hover);
}
</style>
