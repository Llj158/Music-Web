<template>
  <div class="search-loading" v-if="loading">
    <div class="loading-spinner">
      <el-icon class="is-spinning"><loading /></el-icon>
      <span>搜索中...</span>
    </div>
  </div>
  
  <div class="search-results" v-else-if="searchResults.length > 0">
    <el-table 
      :data="searchResults" 
      style="width: 100%"
      @row-click="handlePlay"
      :row-class-name="tableRowClassName"
      :header-cell-style="headerCellStyle"
      @sort-change="handleSortChange"
    >
      <el-table-column width="80">
        <template #header>
          <span class="column-header">序号</span>
        </template>
        <template #default="scope">
          <div class="play-icon-container">
            <el-icon class="play-icon"><video-play /></el-icon>
            <span class="index-number">{{ scope.$index + 1 }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="name" label="歌曲" sortable="custom" min-width="200">
        <template #header>
          <span class="column-header">歌曲</span>
        </template>
        <template #default="scope">
          <div class="song-info">
            <span class="song-name">{{ scope.row.name }}</span>
            <span v-if="scope.row.quality" class="song-quality">{{ scope.row.quality }}</span>
          </div>
        </template>
      </el-table-column>
      <el-table-column prop="singer" label="歌手" sortable="custom" min-width="120">
        <template #header>
          <span class="column-header">歌手</span>
        </template>
      </el-table-column>
      <el-table-column prop="introduction" label="专辑" sortable="custom" min-width="120">
        <template #header>
          <span class="column-header">专辑</span>
        </template>
        <template #default="scope">
          <span class="album-name">{{ scope.row.introduction || '未知专辑' }}</span>
        </template>
      </el-table-column>
    </el-table>
  </div>
  
  <div v-else class="no-results">
    <el-empty description="暂无搜索结果">
      <template #description>
        <p class="empty-description">暂无搜索结果</p>
        <p class="empty-suggestion">请尝试其他关键词</p>
      </template>
    </el-empty>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import { HttpManager } from '@/api';
import { useStore } from 'vuex';
import { ElMessage } from 'element-plus';
import { useRoute } from 'vue-router';
import mixin from '@/mixins/mixin';
import { VideoPlay } from '@element-plus/icons-vue';

interface ResponseBody {
  success: boolean;
  message?: string;
  type?: string;
  data?: any[];
}

interface Singer {
  id: number;
  name: string;
  pic?: string;
}

interface Song {
  id: number;
  name: string;
  url: string;
  pic?: string;
  lyric?: string;
  introduction?: string;
}

const store = useStore();
const route = useRoute();
const searchResults = ref([]);
const originalResults = ref([]);
const loading = ref(false);
const currentSort = ref({ prop: '', order: '' });
const { playMusic } = mixin();

// 处理行点击播放
function handlePlay(row) {
  playMusic({
    id: row.id,
    url: row.url,
    pic: row.pic,
    index: -1,
    name: row.name,
    lyric: row.lyric,
    introduction: row.introduction,
    currentSongList: [row],
  });
}

// 设置行的类名
function tableRowClassName() {
  return 'clickable-row';
}

// 设置表头样式
function headerCellStyle() {
  return {
    backgroundColor: 'rgba(0, 0, 0, 0.02)',
    color: 'rgba(0, 0, 0, 0.85)',
    fontWeight: '600',
    padding: '12px 8px',
    borderBottom: '1px solid rgba(0, 0, 0, 0.06)'
  };
}

// 处理排序变化
function handleSortChange(sort: { prop: string; order: string }) {
  currentSort.value = sort;
  if (!sort.prop) {
    searchResults.value = [...originalResults.value];
    return;
  }

  const sortedList = [...searchResults.value];
  sortedList.sort((a, b) => {
    let valueA = (a[sort.prop] || '').toLowerCase();
    let valueB = (b[sort.prop] || '').toLowerCase();

    if (sort.order === 'ascending') {
      return valueA.localeCompare(valueB);
    } else {
      return valueB.localeCompare(valueA);
    }
  });

  searchResults.value = sortedList;
}

// 搜索歌曲
async function searchSong(keywords: string) {
  if (!keywords?.trim()) {
    searchResults.value = [];
    originalResults.value = [];
    return;
  }
  
  loading.value = true;
  try {
    // 同时搜索歌曲名和歌手名
    const [songResult, singerResult] = await Promise.all([
      HttpManager.getSongOfName(keywords),
      HttpManager.singerOfName(keywords)
    ]) as [ResponseBody, ResponseBody];

    let songsWithSingers = [];

    // 处理通过歌曲名搜索的结果
    if (songResult.success && songResult.data) {
      const songPromises = songResult.data.map(async (song: Song) => {
        try {
          const singerResult = await HttpManager.getSingerOfSongName(song.name) as ResponseBody;
          const singer = singerResult.success && singerResult.data && singerResult.data.length > 0 
            ? singerResult.data[0] as Singer
            : { name: '未知歌手' } as Singer;
            
          return {
            ...song,
            singer: singer.name,
            name: song.name,
            id: song.id,
            url: song.url,
            pic: song.pic || singer.pic,
            lyric: song.lyric,
            introduction: song.introduction
          };
        } catch (error) {
          console.error('获取歌手信息失败:', error);
          return null;
        }
      });
      
      const songResults = (await Promise.all(songPromises)).filter(Boolean);
      songsWithSingers = songsWithSingers.concat(songResults);
    }

    // 处理通过歌手名搜索的结果
    if (singerResult.success && singerResult.data) {
      for (const singer of singerResult.data as Singer[]) {
        try {
          const singerSongsResult = await HttpManager.getSongOfSingerName(singer.name) as ResponseBody;
          if (singerSongsResult.success && singerSongsResult.data) {
            const singerSongs = singerSongsResult.data.map((song: Song) => ({
              ...song,
              singer: singer.name,
              name: song.name,
              id: song.id,
              url: song.url,
              pic: song.pic || singer.pic,
              lyric: song.lyric,
              introduction: song.introduction
            }));
            songsWithSingers = songsWithSingers.concat(singerSongs);
          }
        } catch (error) {
          console.error('获取歌手歌曲失败:', error);
        }
      }
    }

    // 去重处理
    const uniqueSongs = Array.from(new Map(songsWithSingers.map(song => [song.id, song])).values());
    searchResults.value = uniqueSongs;
    originalResults.value = [...uniqueSongs];
    
    // 应用当前排序
    if (currentSort.value.prop) {
      handleSortChange(currentSort.value);
    }
    
    if (searchResults.value.length === 0) {
      ElMessage({
        message: '未找到相关歌曲',
        type: 'info'
      });
    }
  } catch (error) {
    console.error('搜索出错:', error);
    ElMessage({
      message: '搜索请求失败',
      type: 'error'
    });
  } finally {
    loading.value = false;
  }
}

// 监听 vuex 中的搜索关键词变化
watch(() => store.state.searchKeywords, (newKeywords) => {
  searchSong(newKeywords);
});

// 监听路由参数变化
watch(() => route.query.keywords, (newKeywords) => {
  if (typeof newKeywords === 'string' && newKeywords) {
    store.commit('setSearchKeywords', newKeywords);
    searchSong(newKeywords);
  }
});

// 组件挂载时执行搜索
onMounted(() => {
  const keywords = typeof route.query.keywords === 'string' ? route.query.keywords : store.state.searchKeywords;
  if (keywords) {
    store.commit('setSearchKeywords', keywords);
    searchSong(keywords);
  }
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.search-loading {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 300px;
  
  .loading-spinner {
    display: flex;
    flex-direction: column;
    align-items: center;
    
    .is-spinning {
      font-size: 32px;
      color: $color-blue-active;
      margin-bottom: 16px;
    }
    
    span {
      color: rgba(0, 0, 0, 0.45);
      font-size: 14px;
    }
  }
}

.search-results {
  position: relative;
  
  :deep(.el-table) {
    background-color: transparent;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.03);
    
    &::before {
      display: none;
    }
    
    .column-header {
      font-size: 14px;
      font-weight: 600;
      color: rgba(0, 0, 0, 0.85);
    }
    
    th {
      background-color: rgba(0, 0, 0, 0.02);
      border-bottom: 1px solid rgba(0, 0, 0, 0.06);
      padding: 16px 8px;
      transition: background-color 0.2s ease;
      
      &:hover {
        background-color: rgba(0, 0, 0, 0.04);
      }
    }
    
    td {
      border-bottom: 1px solid rgba(0, 0, 0, 0.04);
      padding: 12px 8px;
      color: rgba(0, 0, 0, 0.75);
    }
    
    .clickable-row {
      cursor: pointer;
      transition: all 0.2s ease;
      
      &:hover {
        background-color: rgba(144, 202, 249, 0.08) !important;
        
        .play-icon {
          opacity: 1;
          transform: scale(1);
        }
        
        .index-number {
          opacity: 0;
        }
        
        .song-name {
          color: $color-blue-active;
        }
      }
    }
    
    .play-icon-container {
      position: relative;
      width: 24px;
      height: 24px;
      display: flex;
      align-items: center;
      justify-content: center;
      
      .play-icon {
        position: absolute;
        color: $color-blue-active;
        font-size: 16px;
        opacity: 0;
        transform: scale(0.8);
        transition: all 0.2s ease;
      }
      
      .index-number {
        opacity: 1;
        transition: opacity 0.2s ease;
        color: rgba(0, 0, 0, 0.45);
        font-size: 14px;
      }
    }
    
    .song-info {
      display: flex;
      align-items: center;
      gap: 8px;
      
      .song-name {
        font-weight: 500;
        transition: color 0.2s ease;
      }
      
      .song-quality {
        font-size: 12px;
        padding: 2px 6px;
        border-radius: 4px;
        background-color: rgba(144, 202, 249, 0.1);
        color: $color-blue-active;
      }
    }
    
    .album-name {
      color: rgba(0, 0, 0, 0.65);
      font-size: 14px;
    }
  }
}

.no-results {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 300px;
  
  :deep(.el-empty) {
    .empty-description {
      font-size: 16px;
      color: rgba(0, 0, 0, 0.65);
      margin-bottom: 8px;
    }
    
    .empty-suggestion {
      font-size: 14px;
      color: rgba(0, 0, 0, 0.45);
    }
  }
}
</style>
