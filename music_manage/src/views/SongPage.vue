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
      <el-button type="primary" @click="centerDialogVisible = true" class="fluent-btn fluent-btn-primary">添加歌曲</el-button>
    </div>
    <el-table 
      class="fluent-table"
      border 
      size="small" 
      :data="data" 
      @selection-change="handleSelectionChange"
      @sort-change="handleSortChange"
      :header-cell-style="{backgroundColor: 'var(--fluent-background)', color: 'var(--fluent-text-primary)'}">
      <el-table-column type="selection" width="40"></el-table-column>
      
      <el-table-column label="歌曲图片" width="110" align="center">
        <template v-slot="scope">
          <div class="song-img">
            <img :src="attachImageUrl(scope.row.pic)" class="fluent-table-img" />
            <div class="play" @click="setSongUrl(scope.row)">
              <svg class="icon" aria-hidden="true">
                <use :xlink:href="toggle === scope.row.name ? playIcon : BOFANG"></use>
              </svg>
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="歌名" prop="name" width="150" sortable="custom"></el-table-column>
      <el-table-column label="专辑" prop="introduction" width="150" sortable="custom"></el-table-column>
      <el-table-column label="歌词" align="center">
        <template v-slot="scope">
          <div style="padding: 5px; max-height: 150px; overflow: auto;">
            <div v-for="(item, index) in parseLyric(scope.row.lyric)" :key="index">
              {{ item }}
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="资源更新" width="120" align="center">
        <template v-slot="scope">
          <el-upload :action="updateSongImg(scope.row.id)" :show-file-list="false" :on-success="handleImgSuccess" :before-upload="beforeImgUpload" accept="image/jpeg,image/jpg,image/png,image/gif,image/webp">
            <el-button size="small">更新图片</el-button>
          </el-upload>
          <el-upload :action="updateSongUrl(scope.row.id)" :show-file-list="false" :on-success="handleSongSuccess" :before-upload="beforeSongUpload" accept="audio/mpeg,.mp3" style="margin-top: 5px;">
            <el-button size="small">更新歌曲</el-button>
          </el-upload>
          <el-upload :action="updateSongLrc(scope.row.id)" :show-file-list="false" :on-success="handleSongSuccess" :before-upload="beforeLrcUpload" accept=".lrc,.txt" style="margin-top: 5px;">
            <el-button size="small">更新歌词</el-button>
          </el-upload>
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

  <!--添加歌曲-->
  <el-dialog title="添加歌曲" v-model="centerDialogVisible">
    <el-form id="add-song" label-width="120px" :model="registerForm" class="fluent-form">
      <el-form-item label="歌曲名">
        <el-input type="text" name="name" v-model="registerForm.name" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="专辑">
        <el-input type="text" name="introduction" v-model="registerForm.introduction" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="歌曲封面">
        <input type="file" name="picfile" accept="image/jpeg,image/jpg,image/png,image/gif,image/webp" ref="picfileRef" @change="handlePicChange" />
        <img v-if="previewImage" :src="previewImage" style="max-width: 200px; margin-top: 10px;" />
      </el-form-item>
      <el-form-item label="歌词（有歌词lrc可以直接上传）">
        <el-input type="textarea" name="lyric" v-model="registerForm.lyric" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="歌词lrc上传">
        <input type="file" name="lrcfile" accept=".lrc,.txt" ref="lrcfileRef"/>
      </el-form-item>
      <el-form-item label="歌曲上传">
        <input type="file" name="file" @change="handleMusicFileChange" accept="audio/mpeg,.mp3" ref="musicfileRef"/>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="centerDialogVisible = false" class="fluent-btn fluent-btn-secondary">取 消</el-button>
        <el-button type="primary" @click="addSong" class="fluent-btn fluent-btn-primary">确 定</el-button>
      </span>
    </template>
  </el-dialog>

  <!-- 编辑弹出框 -->
  <el-dialog title="编辑" v-model="editVisible">
    <el-form :model="editForm" class="fluent-form">
      <el-form-item label="歌曲">
        <el-input v-model="editForm.name" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="简介">
        <el-input v-model="editForm.introduction" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="歌词">
        <el-input type="textarea" v-model="editForm.lyric" class="fluent-input"></el-input>
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
import { useStore } from "vuex";
import mixin from "@/mixins/mixin";
import { Icon, RouterName } from "@/enums";
import { HttpManager } from "@/api";
import { parseLyric } from "@/utils";
import DelDialog from "@/components/dialog/DelDialog.vue";
import * as mm from 'music-metadata-browser';

export default defineComponent({
  components: {
    DelDialog,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const { routerManager, beforeImgUpload } = mixin();
    const store = useStore();

    const tableData = ref([]); // 记录歌曲，用于显示
    const tempDate = ref([]); // 记录歌曲，用于搜索时能临时记录一份歌曲列表
    const originalData = ref([]); // 保存原始顺序
    const currentSort = ref({ prop: '', order: '' });
    const pageSize = ref(4); // 页数
    const currentPage = ref(1); // 当前页
    const singerId = ref("");
    const singerName = ref("");
    const toggle = ref(''); // 当前播放的歌曲名
    const BOFANG = Icon.BOFANG;
    const ZANTING = Icon.ZANTING;
    const breadcrumbList = computed(() => store.getters.breadcrumbList);

    const isPlay = computed(() => store.getters.isPlay);
    const playIcon = computed(() => (isPlay.value ? ZANTING : BOFANG));
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

    singerId.value = proxy.$route.query.id as string;
    singerName.value = proxy.$route.query.name as string;
    proxy.$store.commit("setIsPlay", false);
    getData();

    // 获取歌曲
    async function getData() {
      tableData.value = [];
      tempDate.value = [];
      const result = (await HttpManager.getSongOfSingerId(singerId.value)) as ResponseBody;
      tableData.value = result.data;
      tempDate.value = result.data;
      originalData.value = [...result.data]; // 保存原始顺序
      currentPage.value = 1;
    }
    function setSongUrl(row) {
      // 设置当前播放的歌曲URL
      proxy.$store.commit("setUrl", HttpManager.attachImageUrl(row.url));
      
      // 如果点击的是当前播放的歌曲，则切换播放状态
      if (toggle.value === row.name) {
        proxy.$store.commit("setIsPlay", !isPlay.value);
      } else {
        // 如果是新的歌曲，则设置为播放状态
        toggle.value = row.name;
        proxy.$store.commit("setIsPlay", true);
      }
    }
    // 更新歌曲图片
    function updateSongImg(id) {
      return HttpManager.updateSongImg(id);
    }
    function updateSongUrl(id) {
      return HttpManager.updateSongUrl(id);
    }
     function updateSongLrc(id) {
      return HttpManager.updateSongLrc(id);
    }
    // 获取当前页
    function handleCurrentChange(val) {
      currentPage.value = val;
    }
    
    function handleSizeChange(val) {
      pageSize.value = val;
    }
    
    function handleSongSuccess(res) {
      (proxy as any).$message({
        message: res.message,
        type: res.type,
      });
      if (res.success) getData();
    }
     function handleLyricsSuccess(res) {
      (proxy as any).$message({
        message: res.message,
        type: res.type,
      });
      if (res.success) getData();
    }

    // 更新图片
    function handleImgSuccess(res, file) {
      (proxy as any).$message({
        message: res.message,
        type: res.type,
      });
      if (res.success) getData();
    }

    /**
     * 路由
     */
    function goCommentPage(id) {
      const breadcrumbList = reactive([
        {
          path: RouterName.Singer,
          name: "歌手管理",
        },
        {
          path: RouterName.Song,
          query: {
            id: singerId.value,
            name: singerName.value,
          },
          name: "歌曲信息",
        },
        {
          path: "",
          name: "评论详情",
        },
      ]);
      proxy.$store.commit("setBreadcrumbList", breadcrumbList);
      routerManager(RouterName.Comment, { path: RouterName.Comment, query: { id, type: 0 } });
    }

    /**
     * 添加
     */
    const centerDialogVisible = ref(false);
    const registerForm = reactive({
      name: "",
      singerName: "",
      introduction: "",
      lyric: "",
    });
    const picfileRef = ref(null);
    const lrcfileRef = ref(null);
    const musicfileRef = ref(null);
    const previewImage = ref('');

    async function handleMusicFileChange(event) {
      const file = event.target.files[0];
      if (!file) return;

      try {
        const metadata = await mm.parseBlob(file);
        console.log('音乐元数据:', metadata); // 添加调试日志
        
        // 提取标题
        if (metadata.common.title) {
          registerForm.name = metadata.common.title;
        }

        // 提取专辑信息
        if (metadata.common.album) {
          registerForm.introduction = metadata.common.album;
        }

        // 提取封面图片
        if (metadata.common.picture && metadata.common.picture.length > 0) {
          const picture = metadata.common.picture[0];
          const blob = new Blob([picture.data], { type: picture.format });
          const imageUrl = URL.createObjectURL(blob);
          previewImage.value = imageUrl;

          // 创建File对象并设置到文件输入框
          const imageFile = new File([blob], 'cover.' + picture.format.split('/')[1], { type: picture.format });
          const dataTransfer = new DataTransfer();
          dataTransfer.items.add(imageFile);
          picfileRef.value.files = dataTransfer.files;
        }

        // 提取歌词（检查多个可能的来源）
        let lyrics = '';
        if (metadata.common.lyrics && metadata.common.lyrics.length > 0) {
          lyrics = metadata.common.lyrics.join('\n');
        } else if (metadata.native && metadata.native['ID3v2.3'] || metadata.native['ID3v2.4']) {
          const tags = metadata.native['ID3v2.3'] || metadata.native['ID3v2.4'];
          const sylt = tags.find(tag => tag.id === 'SYLT');
          const uslt = tags.find(tag => tag.id === 'USLT');
          
          if (sylt) {
            lyrics = sylt.value.text;
          } else if (uslt) {
            lyrics = uslt.value.text;
          }

        }

        if (lyrics) {
          registerForm.lyric = lyrics;
          console.log('提取到的歌词:', lyrics); // 添加调试日志
        } else {
          console.log('未找到歌词'); // 添加调试日志
        }

        (proxy as any).$message({
          message: "已自动填充音乐信息",
          type: "success",
        });
      } catch (error) {
        console.error('解析MP3文件失败:', error);
        (proxy as any).$message({
          message: "解析MP3文件失败",
          type: "error",
        });
      }
    }

    function addSong() {
      // 验证歌曲名是否为空
      if (!registerForm.name || registerForm.name.trim() === "") {
        (proxy as any).$message.warning("歌曲名不能为空");
        return;
      }

      // 检查必要的文件是否已选择
      if (!musicfileRef.value?.files?.length) {
        (proxy as any).$message.warning('请选择要上传的歌曲文件');
        return;
      }


      const addSongForm = new FormData(document.getElementById("add-song") as HTMLFormElement);
      addSongForm.append("singerId", singerId.value);

      const req = new XMLHttpRequest();
      req.onreadystatechange = () => {
        if (req.readyState === 4 && req.status === 200) {
          let res = JSON.parse(req.response);
          (proxy as any).$message({
            message: res.message,
            type: res.type,
          });
          if (res.success) {
            getData();
            registerForm.name = "";
            registerForm.singerName = "";
            registerForm.introduction = "";
            registerForm.lyric = "";
          }
        }
      };
      console.log(registerForm.name)
      console.log(registerForm.singerName)
      console.log(registerForm.introduction)
      console.log(registerForm.lyric)
      req.open("post", HttpManager.attachImageUrl(`/song/add`), false);
      req.send(addSongForm);
      centerDialogVisible.value = false;
    }

    /**
     * 编辑
     */
    const editVisible = ref(false);
    const editForm = reactive({
      id: "",
      singerId: "",
      name: "",
      introduction: "",
      createTime: "",
      updateTime: "",
      pic: "",
      lyric: "",
      url: "",
    });

    function editRow(row) {
      idx.value = row.id;
      editForm.id = row.id;
      editForm.singerId = row.singerId;
      editForm.name = row.name;
      editForm.introduction = row.introduction;
      editForm.createTime = row.createTime;
      editForm.updateTime = row.updateTime;
      editForm.pic = row.pic;
      editForm.lyric = row.lyric;
      editForm.url = row.url;
      editVisible.value = true;
    }
    async function saveEdit() {
      let id = editForm.id;
      let singerId = editForm.singerId;
      let name = editForm.name;
      let introduction = editForm.introduction;
      let lyric = editForm.lyric;
      const result = (await HttpManager.updateSongMsg({id,singerId,name,introduction,lyric})) as ResponseBody;
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
            const result = (await HttpManager.deleteSong(item.id)) as ResponseBody;
            if (!result.success) {
              (proxy as any).$message.error(`删除歌曲 ${item.name} 失败: ${result.message}`);
            }
          } catch (error) {
            console.error('删除歌曲失败:', error);
            (proxy as any).$message.error(`删除歌曲 ${item.name} 时发生错误`);
          }
        }
        
        (proxy as any).$message.success(`成功删除 ${multipleSelection.value.length} 首歌曲`);
        multipleSelection.value = [];
        isBatchDelete.value = false;
        getData();
      } else {
        // 单个删除操作
        const result = (await HttpManager.deleteSong(idx.value)) as ResponseBody;
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

    function handlePicChange(event) {
      const file = event.target.files[0];
      if (file) {
        previewImage.value = URL.createObjectURL(file);
      } else {
        previewImage.value = '';
      }
    }

    watch(centerDialogVisible, (newVal) => {
      if (!newVal) {
        registerForm.name = '';
        registerForm.introduction = '';
        registerForm.lyric = '';
        previewImage.value = '';
        if (picfileRef.value) picfileRef.value.value = '';
        if (lrcfileRef.value) lrcfileRef.value.value = '';
        if (musicfileRef.value) musicfileRef.value.value = '';
      }
    });

    // 添加歌词文件上传前的验证
    const beforeLrcUpload = (file) => {
      const isLRC = file.name.endsWith('.lrc') || file.name.endsWith('.txt');
      const isLt1M = file.size / 1024 / 1024 < 1;

      if (!isLRC) {
        (proxy as any).$message.error('歌词文件只能是 LRC 或 TXT 格式!');
        return false;
      }
      if (!isLt1M) {
        (proxy as any).$message.error('歌词文件大小不能超过 1MB!');
        return false;
      }
      return true;
    };

    // 音乐文件上传前的验证
    const beforeSongUpload = (file) => {
      const isMP3 = file.type === 'audio/mpeg' || file.name.endsWith('.mp3');
      const isLt20M = file.size / 1024 / 1024 < 20;

      if (!isMP3) {
        (proxy as any).$message.error('音乐文件只能是 MP3 格式!');
        return false;
      }
      if (!isLt20M) {
        (proxy as any).$message.error('音乐文件大小不能超过 20MB!');
        return false;
      }
      return true;
    };

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
      playIcon,
      toggle,
      searchWord,
      data,
      editForm,
      registerForm,
      tableData,
      centerDialogVisible,
      editVisible,
      delVisible,
      pageSize,
      currentPage,
      ZANTING,
      BOFANG,
      breadcrumbList,
      deleteAll,
      handleSelectionChange,
      handleCurrentChange,
      handleImgSuccess,
      beforeImgUpload,
      beforeSongUpload,
      beforeLrcUpload,
      parseLyric,
      saveEdit,
      updateSongImg,
      updateSongUrl,
      updateSongLrc,
      deleteRow,
      confirm,
      attachImageUrl: HttpManager.attachImageUrl,
      addSong,
      editRow,
      handleSongSuccess,
      setSongUrl,
      handleLyricsSuccess,
      goCommentPage,
      picfileRef,
      lrcfileRef,
      musicfileRef,
      previewImage,
      handleMusicFileChange,
      handlePicChange,
      handleSizeChange,
      handleSortChange,
    };
  },
});
</script>

<style scoped>
.song-img {
  position: relative;
  width: 100%;
  height: 80px;
  border-radius: 5px;
  margin-bottom: 5px;
  overflow: hidden;
}

.fluent-table-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  border-radius: 4px;
  transition: var(--fluent-transition);
}

.fluent-table-img:hover {
  transform: scale(1.05);
}

.play {
  position: absolute;
  z-index: 100;
  width: 100%;
  height: 100%;
  top: 0;
  left: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  background-color: rgba(0, 0, 0, 0.2);
  opacity: 0;
  transition: var(--fluent-transition);
}

.play:hover {
  opacity: 1;
}

.icon {
  width: 2em;
  height: 2em;
  color: white;
  fill: currentColor;
  overflow: hidden;
}

.fluent-breadcrumb {
  margin-bottom: 20px;
  padding: 10px;
  background-color: var(--fluent-background);
  border-radius: 4px;
  box-shadow: var(--fluent-box-shadow);
}
</style>

