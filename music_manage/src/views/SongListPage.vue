<template>
  <div class="fluent-container">
    <div class="fluent-handle-box">
      <el-button @click="deleteAll" class="fluent-btn fluent-btn-secondary">批量删除</el-button>
      <el-input v-model="searchWord" placeholder="筛选关键词" class="fluent-input"></el-input>
      <el-button type="primary" @click="centerDialogVisible = true" class="fluent-btn fluent-btn-primary">添加歌单</el-button>
      <el-button type="primary" @click="exportPlaylist" class="fluent-btn fluent-btn-primary">导出歌单</el-button>
    </div>
    <el-table 
      class="fluent-table"
      border 
      size="small" 
      :data="data" 
      @selection-change="handleSelectionChange"
      @sort-change="handleSortChange"
      :header-cell-style="{backgroundColor: 'var(--fluent-background)', color: 'var(--fluent-text-primary)'}">
      <el-table-column type="selection" width="40" align="center"></el-table-column>
      
      <el-table-column label="歌单图片" width="110" align="center">
        <template v-slot="scope">
          <div class="songlist-img">
            <img :src="attachImageUrl(scope.row.pic)" class="fluent-table-img"/>
          </div>
          <el-upload :action="uploadUrl(scope.row.id)" :show-file-list="false" :on-success="handleImgSuccess"
                     :before-upload="beforeImgUpload">
            <el-button size="small">更新图片</el-button>
          </el-upload>
        </template>
      </el-table-column>
      <el-table-column prop="title" label="标题" width="200" sortable="custom"></el-table-column>
      <el-table-column label="简介">
        <template v-slot="scope">
          <p style="padding: 5px;">
            {{ scope.row.introduction }}
          </p>
        </template>
      </el-table-column>
      <el-table-column label="风格" prop="style" width="100"></el-table-column>
      <el-table-column label="歌曲信息" width="90" align="center">
        <template v-slot="scope">
          <el-button @click="goContentPage(scope.row.id)" size="small" type="primary">歌曲信息</el-button>
        </template>
      </el-table-column>
      <el-table-column label="评论" width="90" align="center">
        <template v-slot="scope">
          <el-button @click="goCommentPage(scope.row.id)" size="small" type="primary">评论</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="160" align="center">
        <template v-slot="scope">
          <el-button @click="editRow(scope.row)" size="small" type="primary">编辑</el-button>
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

  <!--添加歌单-->
  <el-dialog title="添加歌单" v-model="centerDialogVisible">
    <el-form label-width="70px" :model="registerForm" class="fluent-form">
      <el-form-item label="歌单名" prop="title">
        <el-input v-model="registerForm.title" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="歌单介绍" prop="introduction">
        <el-input v-model="registerForm.introduction" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="风格" prop="style">
        <el-checkbox-group v-model="selectedStyles" @change="handleStyleChange">
          <el-checkbox v-for="style in styles" :key="style" :label="style">{{ style }}</el-checkbox>
        </el-checkbox-group>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="centerDialogVisible = false" class="fluent-btn fluent-btn-secondary">取 消</el-button>
        <el-button type="primary" @click="addsongList" class="fluent-btn fluent-btn-primary">确 定</el-button>
      </span>
    </template>
  </el-dialog>

  <!-- 编辑弹出框 -->
  <el-dialog title="编辑" v-model="editVisible">
    <el-form :model="editForm" class="fluent-form">
      <el-form-item label="标题">
        <el-input v-model="editForm.title" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="简介">
        <el-input type="textarea" v-model="editForm.introduction" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="风格">
        <el-checkbox-group v-model="editSelectedStyles" @change="handleEditStyleChange">
          <el-checkbox v-for="style in styles" :key="style" :label="style">{{ style }}</el-checkbox>
        </el-checkbox-group>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="editVisible = false" class="fluent-btn fluent-btn-secondary">取 消</el-button>
        <el-button type="primary" @click="saveEdit" class="fluent-btn fluent-btn-primary">确 定</el-button>
      </span>
    </template>
  </el-dialog>

  <!-- 删除提示框 -->
  <del-dialog :delVisible="delVisible" @confirm="confirm" @cancelRow="delVisible = $event"></del-dialog>
</template>

<script lang="ts">
import {computed, defineComponent, getCurrentInstance, reactive, ref, watch} from "vue";
import mixin from "@/mixins/mixin";
import {HttpManager} from "@/api/index";
import {RouterName} from "@/enums";
import DelDialog from "@/components/dialog/DelDialog.vue";
import axios from 'axios';
export default defineComponent({
  components: {
    DelDialog,
  },
  setup() {
    const {proxy} = getCurrentInstance();
    const {routerManager, beforeImgUpload} = mixin();

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
          if (item.title.includes(searchWord.value)) {
            tableData.value.push(item);
          }
        }
      }
    });

    getData();

    // 获取歌单信息
    async function getData() {
      tableData.value = [];
      tempDate.value = [];
      const result = (await HttpManager.getSongList()) as ResponseBody;
      tableData.value = result.data;
      tempDate.value = result.data;
      originalData.value = [...result.data]; // 保存原始顺序
      currentPage.value = 1;
    }

    function exportPlaylist() {
      axios({
        method: 'get',
        url: 'http://localhost:8888/excle',
        responseType: 'blob', // 设置响应类型为blob
      })
        .then((response) => {
          const url = window.URL.createObjectURL(new Blob([response.data]));
          const link = document.createElement('a');
          link.href = url;
          link.setAttribute('download', 'SongList.xlsx'); // 设置下载的文件名
          document.body.appendChild(link);
          link.click();
          link.remove();
        })
        .catch((error) => {
          console.error('导出歌单失败：', error);
        });
  }

    // 获取当前页
    function handleCurrentChange(val) {
      currentPage.value = val;
    }

    function handleSizeChange(val) {
      pageSize.value = val;
    }

    function uploadUrl(id) {
      return HttpManager.attachImageUrl(`/songList/img/update?id=${id}`);
    }

    // 更新图片
    function handleImgSuccess(response, file) {
      (proxy as any).$message({
        message: response.message,
        type: response.type,
      });
      if (response.success) getData();
    }

    /**
     * 路由
     */
    function goContentPage(id) {
      const breadcrumbList = reactive([
        {
          path: RouterName.SongList,
          name: "歌单管理",
        },
        {
          path: "",
          name: "歌单列表",
        },
      ]);
      proxy.$store.commit("setBreadcrumbList", breadcrumbList);
      routerManager(RouterName.ListSong, {path: RouterName.ListSong, query: {id}});
    }

    function goCommentPage(id) {
      const breadcrumbList = reactive([
        {
          path: RouterName.SongList,
          name: "歌单管理",
        },
        {
          path: "",
          name: "评论详情",
        },
      ]);
      proxy.$store.commit("setBreadcrumbList", breadcrumbList);
      routerManager(RouterName.Comment, {path: RouterName.Comment, query: {id, type: 1}});
    }

    /**
     * 添加
     */
    const centerDialogVisible = ref(false);
    const registerForm = reactive({
      title: "",
      introduction: "",
      style: "",
    });

    // 定义歌单风格选项
    const styles = ['华语', '粤语', '日语', '欧美', '纯音乐', '流行', 'ACG'];
    const selectedStyles = ref([]);
    const editSelectedStyles = ref([]);

    // 处理风格选择变化
    function handleStyleChange(value) {
      registerForm.style = value.join('-');
    }

    function handleEditStyleChange(value) {
      editForm.style = value.join('-');
    }

    // 编辑时解析已有的风格
    function parseExistingStyles(styleString) {
      return styleString ? styleString.split('-') : [];
    }

    async function addsongList() {
      let title = registerForm.title;
      let introduction = registerForm.introduction;
      let style = registerForm.style;
      const result = (await HttpManager.setSongList({title, introduction, style})) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
      });

      if (result.success) {
        getData();
        registerForm.title = "";
        registerForm.introduction = "";
        registerForm.style = "";
        selectedStyles.value = [];
      }
      centerDialogVisible.value = false;
    }

    /**
     * 编辑
     */
    const editVisible = ref(false);
    const editForm = reactive({
      id: "",
      title: "",
      pic: "",
      introduction: "",
      style: "",
    });

    function editRow(row) {
      idx.value = row.id;
      Object.assign(editForm, row);
      editSelectedStyles.value = parseExistingStyles(row.style);
      editVisible.value = true;
    }

    async function saveEdit() {

      let id = editForm.id;
      let title = editForm.title;
      let introduction = editForm.introduction;
      let style = editForm.style;

      const result = (await HttpManager.updateSongListMsg({id, title, introduction, style})) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
      });

      if (result.success) getData();
      editVisible.value = false;
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
            const result = await HttpManager.deleteSongList(item.id) as ResponseBody;
            if (!result.success) {
              (proxy as any).$message.error(`删除歌单 ${item.title} 失败: ${result.message}`);
            }
          } catch (error) {
            console.error('删除歌单失败:', error);
            (proxy as any).$message.error(`删除歌单 ${item.title} 时发生错误`);
          }
        }
        
        (proxy as any).$message.success(`成功删除 ${multipleSelection.value.length} 个歌单`);
        multipleSelection.value = [];
        isBatchDelete.value = false;
        getData();
      } else {
        // 单个删除操作
        const result = await HttpManager.deleteSongList(idx.value) as ResponseBody;
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
        let valueA = (a[sort.prop] || '').toString().toLowerCase();
        let valueB = (b[sort.prop] || '').toString().toLowerCase();

        if (sort.order === 'ascending') {
          return valueA.localeCompare(valueB);
        } else {
          return valueB.localeCompare(valueA);
        }
      });

      tableData.value = sortedList;
    }

    return {
      searchWord,
      data,
      tableData,
      centerDialogVisible,
      editVisible,
      delVisible,
      pageSize,
      currentPage,
      registerForm,
      editForm,
      addsongList,
      deleteAll,
      handleSelectionChange,
      handleImgSuccess,
      beforeImgUpload,
      saveEdit,
      attachImageUrl: HttpManager.attachImageUrl,
      uploadUrl,
      editRow,
      handleCurrentChange,
      handleSizeChange,
      exportPlaylist,
      confirm,
      deleteRow,
      goContentPage,
      goCommentPage,
      styles,
      selectedStyles,
      editSelectedStyles,
      handleStyleChange,
      handleEditStyleChange,
      handleSortChange,
    };
  },
});
</script>

<style scoped>
:deep(.el-checkbox-group) {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
}

:deep(.el-checkbox) {
  margin-right: 15px;
  margin-bottom: 10px;
}

.songlist-img {
  width: 100%;
  height: 80px;
  border-radius: 5px;
  margin-bottom: 5px;
  overflow: hidden;
}
</style>
