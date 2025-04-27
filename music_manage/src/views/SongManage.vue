<template>
  <div class="fluent-container">
    <div class="fluent-handle-box">
      <el-button @click="deleteAll" class="fluent-btn fluent-btn-secondary">批量删除</el-button>
      <el-input v-model="searchWord" placeholder="筛选关键词" class="fluent-input"></el-input>
      <el-button type="primary" @click="centerDialogVisible = true" class="fluent-btn fluent-btn-primary add-btn">添加歌曲</el-button>
    </div>
    <el-table 
      class="fluent-table"
      border 
      size="small" 
      :data="data" 
      @selection-change="handleSelectionChange"
      :header-cell-style="{backgroundColor: 'var(--fluent-background)', color: 'var(--fluent-text-primary)'}"
      :fit="true"
      @sort-change="handleSortChange"
      style="width: 100%">
      <el-table-column type="selection" width="40" align="center"></el-table-column>
      
      <el-table-column label="歌曲图片" width="110" align="center">
        <template #default="scope">
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
      <el-table-column prop="name" label="歌曲" width="120" align="center" sortable="custom"></el-table-column>
      <el-table-column prop="singerName" label="歌手" width="120" align="center" sortable="custom"></el-table-column>
      <el-table-column label="专辑" prop="introduction" width="120" align="center" sortable="custom"></el-table-column>
      <el-table-column label="歌词" min-width="250" align="center">
        <template #default="scope">
          <div style="padding: 5px; max-height: 150px; overflow-y: auto; overflow-x: hidden;">
            <div v-for="(item, index) in parseLyric(scope.row.lyric)" :key="index">
              {{ item }}
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column label="资源更新" width="120" align="center">
        <template #default="scope">
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
        <template #default="scope">
          <el-button @click="goCommentPage(scope.row.id)" size="small" type="primary">评论</el-button>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="160" align="center">
        <template #default="scope">
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
      <el-form-item label="歌手">
        <el-select v-model="registerForm.singerId" placeholder="请选择歌手" class="fluent-input">
          <el-option 
            v-for="item in singers" 
            :key="item.id" 
            :label="item.name" 
            :value="item.id">
          </el-option>
        </el-select>
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
      <el-form-item label="歌手">
        <el-select v-model="editForm.singerId" placeholder="请选择歌手" class="fluent-input">
          <el-option 
            v-for="item in singers" 
            :key="item.id" 
            :label="item.name" 
            :value="item.id">
          </el-option>
        </el-select>
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
    const singers = ref([]); // 记录所有歌手
    const pageSize = ref(4); // 页数
    const currentPage = ref(1); // 当前页
    const toggle = ref(''); // 当前播放的歌曲名
    const BOFANG = Icon.BOFANG;
    const ZANTING = Icon.ZANTING;

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

    proxy.$store.commit("setIsPlay", false);
    getSingers();

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

    // 获取歌曲
    async function getData() {
      try {
        const result = (await HttpManager.getAllSong()) as ResponseBody;
        if (result.success) {
          // 获取歌曲数据并添加歌手名称
          const songs = result.data;
          const songsWithSingerName = songs.map(song => {
            const singer = singers.value.find(s => s.id === song.singerId);
            return {
              ...song,
              singerName: singer ? singer.name : '未知歌手'
            };
          });
          tableData.value = songsWithSingerName;
          tempDate.value = songsWithSingerName;
          originalData.value = [...songsWithSingerName]; // 保存原始顺序
          currentPage.value = 1;
        }
      } catch (error) {
        console.error('获取歌曲失败:', error);
        (proxy as any).$message.error('获取歌曲失败');
      }
    }

    // 获取所有歌手
    async function getSingers() {
      try {
        const result = (await HttpManager.getAllSinger()) as ResponseBody;
        if (result.success) {
          singers.value = result.data;
          // 获取歌手后重新获取歌曲列表以显示歌手名称
          getData();
        }
      } catch (error) {
        console.error('获取歌手失败:', error);
        (proxy as any).$message.error('获取歌手失败');
      }
    }

    function setSongUrl(row) {
      proxy.$store.commit("setUrl", HttpManager.attachImageUrl(row.url));
      if (toggle.value === row.name) {
        proxy.$store.commit("setIsPlay", !isPlay.value);
      } else {
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

    // 更新图片
    function handleImgSuccess(res) {
      (proxy as any).$message({
        message: res.message,
        type: res.type,
      });
      if (res.success) getData();
    }

    function goCommentPage(id) {
      routerManager(RouterName.Comment, { path: RouterName.Comment, query: { id, type: 0 } });
    }

    /**
     * 添加
     */
    const centerDialogVisible = ref(false);
    const registerForm = reactive({
      name: "",
      singerId: "",
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
        // 先清空所有相关字段
        registerForm.name = "";
        registerForm.introduction = "";
        registerForm.singerId = "";
        registerForm.lyric = "";
        previewImage.value = '';
        if (picfileRef.value) picfileRef.value.value = '';

        const metadata = await mm.parseBlob(file);
        let hasExtractedInfo = false;

        // 提取标题
        if (metadata.common.title) {
          registerForm.name = metadata.common.title;
          hasExtractedInfo = true;
        }

        // 提取专辑信息
        if (metadata.common.album) {
          registerForm.introduction = metadata.common.album;
          hasExtractedInfo = true;
        }

        // 提取歌手信息并匹配
        if (metadata.common.artist) {
          const artist = metadata.common.artist;
          const matchedSinger = singers.value.find(
            singer => singer.name.toLowerCase() === artist.toLowerCase()
          );
          if (matchedSinger) {
            registerForm.singerId = matchedSinger.id;
            (proxy as any).$message.success(`已匹配到歌手: ${matchedSinger.name}`);
            hasExtractedInfo = true;
          } else {
            (proxy as any).$message.warning(`未找到匹配的歌手: ${artist}，请手动选择`);
          }
        }

        // 提取封面图片
        if (metadata.common.picture && metadata.common.picture.length > 0) {
          const picture = metadata.common.picture[0];
          const blob = new Blob([picture.data], { type: picture.format });
          const imageUrl = URL.createObjectURL(blob);
          previewImage.value = imageUrl;

          const imageFile = new File([blob], 'cover.' + picture.format.split('/')[1], { type: picture.format });
          const dataTransfer = new DataTransfer();
          dataTransfer.items.add(imageFile);
          picfileRef.value.files = dataTransfer.files;
          hasExtractedInfo = true;
        }

        // 提取歌词
        let hasLyrics = false;
        if (metadata.common.lyrics && metadata.common.lyrics.length > 0) {
          registerForm.lyric = metadata.common.lyrics.join('\n');
          hasLyrics = true;
        } else if (metadata.native && metadata.native['ID3v2.3'] || metadata.native['ID3v2.4']) {
          const tags = metadata.native['ID3v2.3'] || metadata.native['ID3v2.4'];
          const sylt = tags.find(tag => tag.id === 'SYLT');
          const uslt = tags.find(tag => tag.id === 'USLT');
          
          if (sylt) {
            registerForm.lyric = sylt.value.text;
            hasLyrics = true;
          } else if (uslt) {
            registerForm.lyric = uslt.value.text;
            hasLyrics = true;
          }
        }

        if (hasLyrics) {
          hasExtractedInfo = true;
        }

        if (hasExtractedInfo) {
          (proxy as any).$message.success('已自动填充可用的音乐信息');
        } else {
          (proxy as any).$message.warning('未能从音乐文件中提取到任何信息');
        }
      } catch (error) {
        console.error('解析MP3文件失败:', error);
        (proxy as any).$message.error('解析MP3文件失败');
        
        // 发生错误时清空所有字段
        registerForm.name = "";
        registerForm.introduction = "";
        registerForm.singerId = "";
        registerForm.lyric = "";
        previewImage.value = '';
        if (picfileRef.value) picfileRef.value.value = '';
      }
    }

    function addSong() {
      if (!registerForm.name || !registerForm.singerId) {
        (proxy as any).$message.warning('请填写歌曲名和选择歌手');
        return;
      }

      // 检查必要的文件是否已选择
      if (!musicfileRef.value?.files?.length) {
        (proxy as any).$message.warning('请选择要上传的歌曲文件');
        return;
      }
      const form = document.getElementById("add-song") as HTMLFormElement;
      if (!form) {
        (proxy as any).$message.error('表单不存在');
        return;
      }

      const addSongForm = new FormData(form);
      // 确保添加singerId到表单数据中
      addSongForm.append("singerId", registerForm.singerId);

      const req = new XMLHttpRequest();
      req.onreadystatechange = () => {
        if (req.readyState === 4) {
          if (req.status === 200) {
            let res = JSON.parse(req.response);
            (proxy as any).$message({
              message: res.message,
              type: res.type,
            });

            if (res.success) {
              getData();
              registerForm.name = "";
              registerForm.singerId = "";
              registerForm.introduction = "";
              registerForm.lyric = "";
              previewImage.value = '';
              if (picfileRef.value) picfileRef.value.value = '';
              if (lrcfileRef.value) lrcfileRef.value.value = '';
              if (musicfileRef.value) musicfileRef.value.value = '';
            }
          } else {
            (proxy as any).$message.error('上传失败，请重试');
          }
        }
      };

      req.open("post", HttpManager.attachImageUrl('/song/add'), false);
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
      Object.assign(editForm, row);
      editVisible.value = true;
    }

    async function saveEdit() {
      const { id, singerId, name, introduction, lyric } = editForm;
      const result = (await HttpManager.updateSongMsg({ id, singerId, name, introduction, lyric })) as ResponseBody;
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
    const idx = ref(-1);
    const multipleSelection = ref([]);
    const delVisible = ref(false);
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
        registerForm.singerId = '';
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

    return {
      playIcon,
      toggle,
      searchWord,
      data,
      editForm,
      registerForm,
      tableData,
      singers,
      centerDialogVisible,
      editVisible,
      delVisible,
      pageSize,
      currentPage,
      ZANTING,
      BOFANG,
      deleteAll,
      handleSelectionChange,
      handleCurrentChange,
      handleSizeChange,
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
      goCommentPage,
      picfileRef,
      lrcfileRef,
      musicfileRef,
      previewImage,
      handleMusicFileChange,
      handlePicChange,
      handleSortChange,
    };
  },
});
</script>

<style scoped>
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

.fluent-table-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.song-img {
  position: relative;
  width: 80px;
  height: 80px;
  overflow: hidden;
  border-radius: 5px;
  margin: 0 auto;
}

.play {
  position: absolute;
  z-index: 100;
  width: 80px;
  height: 80px;
  top: 0;
  left: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
}

.icon {
  width: 2em;
  height: 2em;
  color: white;
  fill: currentColor;
  overflow: hidden;
}

:deep(.el-table) {
  border-radius: 8px;
  margin-top: 10px;
}

:deep(.el-table__header) {
  font-weight: bold;
}

:deep(.el-table__row) {
  height: 100px;
}

:deep(.el-table__body-wrapper) {
  overflow-x: hidden !important;
}

:deep(.el-table__header-wrapper) {
  overflow-x: hidden !important;
}

.fluent-pagination {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}

.fluent-form {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.fluent-input {
  width: 100%;
}

:deep(.el-form-item__label),
:deep(.el-input__inner),
:deep(.el-textarea__inner),
:deep(.el-select-dropdown__item) {
  font-size: 14px;
}

.fluent-btn {
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
}

.fluent-btn-primary {
  background-color: var(--fluent-primary);
  color: var(--fluent-text-on-primary);
}

.add-btn {
  color: #ffffff;
}

.fluent-btn-secondary {
  background-color: var(--fluent-secondary);
  color: var(--fluent-text-on-secondary);
}
</style>