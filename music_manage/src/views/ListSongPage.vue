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
      <el-button type="primary" @click="centerDialogVisible = true" class="fluent-btn fluent-btn-primary add-btn">添加歌曲</el-button>
    </div>
    <el-table 
      class="fluent-table"
      border 
      size="small" 
      :data="tableData" 
      @selection-change="handleSelectionChange"
      :header-cell-style="{backgroundColor: 'var(--fluent-background)', color: 'var(--fluent-text-primary)'}">
      <el-table-column type="selection" width="40" align="center"></el-table-column>
      <el-table-column label="ID" prop="id" width="50" align="center"></el-table-column>
      <el-table-column label="歌曲" prop="name" align="center"></el-table-column>
      <el-table-column label="歌手" prop="singer.name" align="center"></el-table-column>
      <el-table-column label="操作" width="90" align="center">
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

  <!--添加歌曲-->
  <el-dialog title="添加歌曲" v-model="centerDialogVisible">
    <el-form label-width="80px" :model="registerForm" class="fluent-form">
      <el-form-item prop="search" label="快速搜索">
        <el-autocomplete v-model="searchQuery" :fetch-suggestions="querySearch" placeholder="输入歌手名或歌曲名"
          @select="handleSelect" :trigger-on-focus="false" class="fluent-input">
          <template #default="{ item }">
            <div class="suggestion-item">
              <span>{{ item.label }}</span>
            </div>
          </template>
        </el-autocomplete>
      </el-form-item>
      <el-divider>列表选择</el-divider>
      <el-form-item prop="singerName" label="选择歌手">
        <el-select v-model="registerForm.singerName" placeholder="请选择歌手" @change="handleSingerChange" filterable class="fluent-input">
          <el-option v-for="item in singerList" :key="item.name" :label="item.name" :value="item.name" />
        </el-select>
      </el-form-item>
      <el-form-item prop="songName" label="选择歌曲">
        <el-select v-model="registerForm.songName" placeholder="请选择歌曲" filterable class="fluent-input">
          <el-option v-for="item in songList" :key="item.name" :label="item.name" :value="item.name" />
        </el-select>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="centerDialogVisible = false" class="fluent-btn fluent-btn-secondary">取 消</el-button>
        <el-button type="primary" @click="saveSong()" class="fluent-btn fluent-btn-primary">确 定</el-button>
      </span>
    </template>
  </el-dialog>

  <!-- 删除提示框 -->
  <del-dialog :delVisible="delVisible" @confirm="confirm" @cancelRow="delVisible = $event"></del-dialog>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, watch, ref, reactive, computed } from "vue";
import { useStore } from "vuex";
import { HttpManager } from "@/api";
import DelDialog from "@/components/dialog/DelDialog.vue";
import { ElDivider } from 'element-plus'

interface ResponseBody {
  code: number;
  success: boolean;
  message: string;
  type: string;
  data: any;
}

interface Singer {
  id: number;
  name: string;
}

interface Song {
  id: number;
  name: string;
  singer?: Singer;
}

export default defineComponent({
  components: {
    DelDialog,
    ElDivider,
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
          if (item.name.includes(searchWord.value)) {
            tableData.value.push(item);
          }
        }
      }
    });

    getData();

    // 获取歌单
    async function getData() {
      tableData.value = [];
      tempDate.value = [];
      const result = (await HttpManager.getListSongOfSongId(proxy.$route.query.id)) as ResponseBody;
      for (let item of result.data) {
        const songResult = await HttpManager.getSongOfId(item.songId) as ResponseBody;
        const song = songResult.data[0];
        if (song) {
          // 获取歌手信息
          const singerResult = await HttpManager.getSingerOfSongName(song.name) as ResponseBody;
          if (singerResult.success && singerResult.data.length > 0) {
            song.singer = singerResult.data[0];
          }
          tableData.value.push(song);
          tempDate.value.push(song);
        }
      }
    }

    /**
     * 添加
     */
    const centerDialogVisible = ref(false);
    const registerForm = reactive({
      singerName: "",
      songName: "",
    });

    // 歌手列表和歌曲列表
    const singerList = ref([]);
    const songList = ref([]);

    // 获取所有歌手
    async function getAllSingers() {
      const result = (await HttpManager.getAllSinger()) as ResponseBody;
      if (result.success) {
        singerList.value = result.data;
      }
    }

    // 当选择歌手时获取该歌手的所有歌曲
    async function handleSingerChange(singerName) {
      if (!singerName) {
        songList.value = [];
        return;
      }
      const result = (await HttpManager.getSongOfSingerName(singerName)) as ResponseBody;
      if (result.success) {
        // 为每首歌曲添加歌手信息
        songList.value = result.data.map(song => ({
          ...song,
          singer: { name: singerName }
        }));
      }
    }

    // 搜索相关
    const searchQuery = ref('');
    const searchResults = ref([]);
    const allSongs = ref([]);

    // 获取所有歌曲数据
    async function getAllSongsData() {
      try {
        const result = (await HttpManager.getAllSinger()) as ResponseBody;
        if (result.success) {
          // 清空之前的数据
          searchResults.value = [];
          allSongs.value = [];

          // 处理歌手数据
          result.data.forEach(singer => {
            searchResults.value.push({
              value: singer.name,
              label: `${singer.name} (歌手)`,
              name: singer.name,
              type: 'singer',
              id: singer.id
            });
          });
        }
      } catch (error) {
        console.error('获取数据失败:', error);
        (proxy as any).$message({
          message: "获取数据失败，请稍后重试",
          type: "error"
        });
      }
    }

    // 搜索建议
    function querySearch(queryString: string, cb: (arg: any) => void) {
      if (!queryString?.trim()) {
        cb([]);
        return;
      }

      // 同时搜索歌曲名和歌手名
      Promise.all([
        HttpManager.getSongOfName(queryString),
        HttpManager.getAllSinger()
      ]).then(async ([songResult, singerResult]: any[]) => {
        let suggestions = [];

        // 处理歌手搜索结果
        if (singerResult?.success && Array.isArray(singerResult.data)) {
          // 过滤匹配的歌手
          const matchedSingers = singerResult.data
            .filter(singer => singer.name.toLowerCase().includes(queryString.toLowerCase()))
            .map(singer => ({
              value: singer.name,
              label: `${singer.name} (歌手)`,
              type: 'singer',
              name: singer.name
            }));

          // 对于每个匹配的歌手，获取他们的歌曲
          for (const singer of matchedSingers) {
            suggestions.push(singer); // 先添加歌手建议
            try {
              const singerSongsResult = await HttpManager.getSongOfSingerName(singer.name) as ResponseBody;
              if (singerSongsResult.success && singerSongsResult.data) {
                const singerSongs = singerSongsResult.data.map(song => ({
                  value: song.name,
                  label: `${song.name} - ${singer.name}`,
                  type: 'song',
                  singer: singer.name,
                  songId: song.id,
                  name: song.name
                }));
                suggestions = suggestions.concat(singerSongs);
              }
            } catch (error) {
              console.error('获取歌手歌曲失败:', error);
            }
          }
        }

        // 处理歌曲搜索结果（歌曲名匹配的情况）
        if (songResult?.success && Array.isArray(songResult.data)) {
          const songPromises = songResult.data.map(async song => {
            try {
              const singerResult = await HttpManager.getSingerOfSongName(song.name) as ResponseBody;
              const singer = singerResult.success && singerResult.data && singerResult.data.length > 0 
                ? singerResult.data[0] 
                : { name: '未知歌手' };

              return {
                value: song.name,
                label: `${song.name} - ${singer.name}`,
                type: 'song',
                singer: singer.name,
                songId: song.id,
                name: song.name
              };
            } catch (error) {
              console.error('获取歌手信息失败:', error);
              return null;
            }
          });

          const songSuggestions = (await Promise.all(songPromises)).filter(Boolean);
          // 添加不重复的歌曲
          songSuggestions.forEach(song => {
            if (!suggestions.some(s => s.type === 'song' && s.songId === song.songId)) {
              suggestions.push(song);
            }
          });
        }

        cb(suggestions);
      }).catch(error => {
        console.error('搜索失败:', error);
        cb([]);
      });
    }

    // 选择搜索结果
    async function handleSelect(item) {
      if (!item) return;

      try {
        if (item.type === 'singer') {
          registerForm.singerName = item.name;
          await handleSingerChange(item.name);
        } else if (item.type === 'song') {
          registerForm.singerName = item.singer;
          registerForm.songName = item.name;
          await handleSingerChange(item.singer);
        }
        searchQuery.value = '';
      } catch (error) {
        console.error('处理选择结果失败:', error);
        (proxy as any).$message({
          message: '处理选择结果失败，请重试',
          type: 'error'
        });
      }
    }

    // 打开对话框时加载所有数据
    watch(centerDialogVisible, async (newVal) => {
      if (newVal) {
        await getAllSingers();
        await getAllSongsData();
      } else {
        // 关闭对话框时清空表单
        registerForm.singerName = "";
        registerForm.songName = "";
        songList.value = [];
        searchQuery.value = "";
      }
    });

    // 获取要添加歌曲的ID
    async function saveSong() {
      // 验证输入
      if (!registerForm.singerName || !registerForm.songName) {
        (proxy as any).$message({
          message: "请选择歌手和歌曲",
          type: "error"
        });
        return;
      }

      try {
        // 通过歌曲名获取歌手信息进行验证
        const singerResult = await HttpManager.getSingerOfSongName(registerForm.songName) as ResponseBody;
        if (!singerResult.success || !singerResult.data || singerResult.data.length === 0) {
          (proxy as any).$message({
            message: "未找到该歌曲的歌手信息",
            type: "error"
          });
          return;
        }

        // 验证歌手名是否匹配
        const singer = singerResult.data[0];
        if (singer.name !== registerForm.singerName) {
          (proxy as any).$message({
            message: "选择的歌手与歌曲不匹配",
            type: "error"
          });
          return;
        }

        // 获取歌曲信息
        const songResult = await HttpManager.getSongOfName(registerForm.songName) as ResponseBody;
        if (!songResult.success || !songResult.data || songResult.data.length === 0) {
          (proxy as any).$message({
            message: "未找到该歌曲信息",
            type: "error"
          });
          return;
        }

        // 找到匹配的歌曲
        const song = songResult.data.find(s => s.name === registerForm.songName);
        if (song) {
          addSong(song.id);
        } else {
          (proxy as any).$message({
            message: "未找到该歌曲，请重新选择",
            type: "error"
          });
        }
      } catch (error: any) {
        console.error('保存歌曲失败:', error);
        (proxy as any).$message({
          message: error.message || "添加歌曲失败，请重试",
          type: "error"
        });
      }
      centerDialogVisible.value = false;
    }

    async function addSong(id) {
      // 验证参数
      if (!id || !proxy.$route.query.id) {
        (proxy as any).$message({
          message: "歌曲ID或歌单ID无效",
          type: "error"
        });
        return;
      }

      let songId = id;
      let songListId = proxy.$route.query.id as string;

      const result = (await HttpManager.setListSong({ songId, songListId })) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
      });

      if (result.success) {
        getData();
        // 清空表单
        registerForm.singerName = "";
        registerForm.songName = "";
      }

      centerDialogVisible.value = false;
    }

    /**
     * 删除
     */
    const idx = ref<number | number[]>(-1); // 记录当前要删除的行或行列表
    const multipleSelection = ref<Song[]>([]); // 记录当前要删除的列表
    const delVisible = ref(false); // 显示删除框

    function deleteAll() {
      if (multipleSelection.value.length === 0) {
        (proxy as any).$message({
          message: "请选择要删除的歌曲",
          type: "warning"
        });
        return;
      }

      delVisible.value = true;
      // 设置要删除的ID列表
      idx.value = multipleSelection.value.map(item => item.id);
    }

    async function confirm() {
      try {
        if (Array.isArray(idx.value)) {
          // 批量删除
          for (let id of idx.value) {
            const result = await HttpManager.deleteListSong(id) as ResponseBody;
            if (!result.success) {
              throw new Error(result.message || "删除失败");
            }
          }
          (proxy as any).$message({
            message: "批量删除成功",
            type: "success"
          });
        } else {
          // 单个删除
          const result = await HttpManager.deleteListSong(idx.value) as ResponseBody;
          (proxy as any).$message({
            message: result.message,
            type: result.type,
          });
        }

        getData();
        multipleSelection.value = [];
        delVisible.value = false;
      } catch (error: any) {
        console.error('删除失败:', error);
        (proxy as any).$message({
          message: error.message || "删除失败，请重试",
          type: "error"
        });
      }
    }
    function deleteRow(id) {
      idx.value = id;
      delVisible.value = true;
    }
    function handleSelectionChange(val) {
      multipleSelection.value = val;
    }

    return {
      searchWord,
      tableData,
      delVisible,
      centerDialogVisible,
      registerForm,
      breadcrumbList,
      deleteAll,
      handleSelectionChange,
      deleteRow,
      confirm,
      saveSong,
      singerList,
      songList,
      handleSingerChange,
      searchQuery,
      querySearch,
      handleSelect,
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

.fluent-btn-danger {
  background-color: #f56c6c;
  color: #fff;
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

:deep(.el-form-item__label),
:deep(.el-input__inner),
:deep(.el-textarea__inner),
:deep(.el-select-dropdown__item) {
  font-size: 14px;
}

.suggestion-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 4px 0;
}

.el-divider {
  margin: 16px 0;
}
</style>
