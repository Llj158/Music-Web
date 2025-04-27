<template>
  <div class="fluent-container">
    <div class="fluent-handle-box">
      <el-button @click="deleteAll" class="fluent-btn fluent-btn-secondary">批量删除</el-button>
      <el-input placeholder="筛选歌手" v-model="searchWord" class="fluent-input"></el-input>
      <el-button type="primary" @click="centerDialogVisible = true" class="fluent-btn fluent-btn-primary">添加歌手</el-button>
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
      <el-table-column label="歌手图片" prop="pic" width="110" align="center">
        <template v-slot="scope">
          <div class="singer-img">
            <img :src="attachImageUrl(scope.row.pic)" class="fluent-table-img" />
          </div>
          <el-upload :action="uploadUrl(scope.row.id)" :show-file-list="false" :on-success="handleImgSuccess" :before-upload="beforeImgUpload">
            <el-button size="small">更新图片</el-button>
          </el-upload>
        </template>
      </el-table-column>
      <el-table-column label="歌手" prop="name" width="120" align="center" sortable="custom"></el-table-column>
      <el-table-column label="性别" prop="sex" width="60" align="center">
        <template v-slot="scope">
          <div>{{ changeSex(scope.row.sex, 'singer') }}</div>
        </template>
      </el-table-column>
      <el-table-column label="出生" prop="birth" width="120" align="center">
        <template v-slot="scope">
          <div>{{ getBirth(scope.row.birth) }}</div>
        </template>
      </el-table-column>
      <el-table-column label="地区" prop="location" width="100" align="center"></el-table-column>
      <el-table-column label="简介" prop="introduction">
        <template v-slot="scope">
          <p style="padding: 5px;">
            {{ scope.row.introduction }}
          </p>
        </template>
      </el-table-column>
      <el-table-column label="歌曲管理" width="120" align="center">
        <template v-slot="scope">
          <el-button @click="goSongPage(scope.row)" size="small" type="primary">歌曲管理</el-button>
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

  <!-- 添加 -->
  <el-dialog title="添加歌手" v-model="centerDialogVisible">
    <el-form label-width="80px" :model="registerForm" :rules="singerRule" class="fluent-form">
      <el-form-item label="歌手名" prop="name">
        <el-input v-model="registerForm.name" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="sex">
        <el-radio-group v-model="registerForm.sex">
          <el-radio :label="0">女</el-radio>
          <el-radio :label="1">男</el-radio>
          <el-radio :label="2">组合</el-radio>
          <el-radio :label="3">不明</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="故乡" prop="location">
        <el-input v-model="registerForm.location" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="出生日期" prop="birth">
        <el-date-picker type="date" v-model="registerForm.birth"></el-date-picker>
      </el-form-item>
      <el-form-item label="歌手介绍" prop="introduction">
        <el-input type="textarea" v-model="registerForm.introduction" class="fluent-input"></el-input>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="centerDialogVisible = false" class="fluent-btn fluent-btn-secondary">取 消</el-button>
        <el-button type="primary" @click="addsinger" class="fluent-btn fluent-btn-primary">确 定</el-button>
      </span>
    </template>
  </el-dialog>

  <!-- 编辑弹出框 -->
  <el-dialog title="编辑" v-model="editVisible">
    <el-form label-width="60px" :model="editForm" :rules="singerRule" class="fluent-form">
      <el-form-item label="歌手" prop="name">
        <el-input v-model="editForm.name" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="性别" prop="sex">
        <el-radio-group v-model="editForm.sex">
          <el-radio :label="0">女</el-radio>
          <el-radio :label="1">男</el-radio>
          <el-radio :label="2">组合</el-radio>
          <el-radio :label="3">不明</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item label="出生" prop="birth">
        <el-date-picker type="date" v-model="editForm.birth"></el-date-picker>
      </el-form-item>
      <el-form-item label="地区" prop="location">
        <el-input v-model="editForm.location" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="简介" prop="introduction">
        <el-input type="textarea" v-model="editForm.introduction" class="fluent-input"></el-input>
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
import { defineComponent, getCurrentInstance, watch, ref, reactive, computed } from "vue";
import mixin from "@/mixins/mixin";
import DelDialog from "@/components/dialog/DelDialog.vue";
import { HttpManager } from "@/api/index";
import { RouterName } from "@/enums";
import { getBirth } from "@/utils";

export default defineComponent({
  components: {
    DelDialog,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const { changeSex, routerManager, beforeImgUpload } = mixin();

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
          if (item.name.includes(searchWord.value)) {
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

    getData();

    async function getData() {
      tableData.value = [];
      tempDate.value = [];
      const result = (await HttpManager.getAllSinger()) as ResponseBody;
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
    
    function uploadUrl(id) {
      return HttpManager.attachImageUrl(`/singer/avatar/update?id=${id}`);
    }

    /**
     * 路由
     */
    function goSongPage(row) {
      const breadcrumbList = reactive([
        {
          path: RouterName.Singer,
          name: "歌手管理",
        },
        {
          path: "",
          name: "歌曲信息",
        },
      ]);
      proxy.$store.commit("setBreadcrumbList", breadcrumbList);
      routerManager(RouterName.Song, {
        path: RouterName.Song,
        query: { id: row.id, name: row.name },
      });
    }

    /**
     * 添加
     */
    const centerDialogVisible = ref(false);
    const registerForm = reactive({
      name: "",
      sex: "",
      birth: new Date(),
      location: "",
      introduction: "",
    });
    const singerRule = reactive({
      name: [{ required: true, trigger: "change" }],
      sex: [{ required: true, trigger: "change" }],
    });

    async function addsinger() {
      let datetime = getBirth(registerForm.birth);

      let name = registerForm.name;
      let sex = registerForm.sex;
      let birth = datetime;
      let location = registerForm.location;
      let introduction = registerForm.introduction;

      const result = (await HttpManager.setSinger({name,sex,birth,location,introduction})) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
      });

      if (result.success) {
        getData();
        registerForm.birth = new Date();
        registerForm.name = "";
        registerForm.sex = "";
        registerForm.location = "";
        registerForm.introduction = "";
      }
      centerDialogVisible.value = false;
    }

    /**
     * 编辑
     */
    const editVisible = ref(false);
    const editForm = reactive({
      id: "",
      name: "",
      sex: "",
      pic: "",
      birth: new Date(),
      location: "",
      introduction: "",
    });

    function editRow(row) {
      editVisible.value = true;
      editForm.id = row.id;
      editForm.name = row.name;
      editForm.sex = row.sex;
      editForm.pic = row.pic;
      editForm.birth = row.birth;
      editForm.location = row.location;
      editForm.introduction = row.introduction;
    }
    async function saveEdit() {
      try {
        let datetime = getBirth(new Date(editForm.birth));

        let id = editForm.id;
        let name = editForm.name;
        let sex = editForm.sex;
        let birth = datetime;
        let location = editForm.location;
        let introduction = editForm.introduction;

        const result = (await HttpManager.updateSingerMsg({id,name,sex,birth,location,introduction})) as ResponseBody;
        (proxy as any).$message({
          message: result.message,
          type: result.type,
        });

        if (result.success) getData();
        editVisible.value = false;
      } catch (error) {
        console.error(error);
      }
    }
    function handleImgSuccess(response, file) {
      (proxy as any).$message({
        message: response.message,
        type: response.type,
      });
      if (response.success) getData();
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
            const result = (await HttpManager.deleteSinger(item.id)) as ResponseBody;
            if (!result.success) {
              (proxy as any).$message.error(`删除歌手 ${item.name} 失败: ${result.message}`);
            }
          } catch (error) {
            console.error('删除歌手失败:', error);
            (proxy as any).$message.error(`删除歌手 ${item.name} 时发生错误`);
          }
        }
        
        (proxy as any).$message.success(`成功删除 ${multipleSelection.value.length} 名歌手`);
        multipleSelection.value = [];
        isBatchDelete.value = false;
        getData();
      } else {
        // 单个删除操作
        const result = (await HttpManager.deleteSinger(idx.value)) as ResponseBody;
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
      data,
      tableData,
      centerDialogVisible,
      editVisible,
      delVisible,
      pageSize,
      currentPage,
      registerForm,
      editForm,
      singerRule,
      deleteAll,
      handleSelectionChange,
      handleImgSuccess,
      beforeImgUpload,
      saveEdit,
      attachImageUrl: HttpManager.attachImageUrl,
      changeSex,
      getBirth,
      uploadUrl,
      goSongPage,
      editRow,
      handleCurrentChange,
      handleSizeChange,
      addsinger,
      confirm,
      deleteRow,
      handleSortChange,
    };
  },
});
</script>

<style scoped>
.singer-img {
  width: 100%;
  height: 80px;
  border-radius: 5px;
  margin-bottom: 5px;
  overflow: hidden;
}
</style>
