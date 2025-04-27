<template>
  <div class="home-container">
    <!--主要区域-->
    <div class="simple-banner">
      <div class="banner-content">
        <h1 class="banner-title">Music</h1>
        <p class="banner-subtitle">JLU</p>
        <div class="search-container">
          <div class="search-box">
            <input 
              class="search-left"
              v-model="searchKeyword"
              placeholder="输入歌曲或歌手" 
              @keyup.enter="handleSearch"
            />
            <button class="search-right" @click="handleSearch">
              搜索
            </button>
          </div>
        </div>
        <div class="music-controls">
          <button class="control-btn play-random-btn" @click="playRandomSong">
            随机播放
          </button>
        </div>
      </div>
    </div>

    <!--内容区域-->
    <div class="content-section">
      <!--热门歌单-->
      <div class="section-container">
        <div class="section-header">
          <h2 class="section-title">歌单</h2>
          <button class="refresh-btn" @click="refreshSongList">
            <el-icon><refresh /></el-icon>
            换一批
          </button>
        </div>
        <play-list class="play-list-container" path="song-sheet-detail" :playList="songList"></play-list>
      </div>

      <!--热门歌手-->
      <div class="section-container">
        <div class="section-header">
          <h2 class="section-title">歌手</h2>
          <button class="refresh-btn" @click="refreshSingerList">
            <el-icon><refresh /></el-icon>
            换一批
          </button>
        </div>
        <play-list class="play-list-container" path="singer-detail" :playList="singerList"></play-list>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, onMounted, computed } from "vue";
import { useRouter } from "vue-router";
import { useStore } from "vuex";
import { Search, Refresh } from "@element-plus/icons-vue";
import PlayList from "@/components/PlayList.vue";
import { NavName } from "@/enums";
import { HttpManager } from "@/api";
import mixin from "@/mixins/mixin";

const router = useRouter();
const allSongLists = ref([]);
const allSingers = ref([]);
const songList = ref([]); // 显示的歌单列表
const singerList = ref([]); // 显示的歌手列表
const { changeIndex, playMusic } = mixin();
const searchKeyword = ref('');

// 添加一个存储所有歌曲的数组
const allSongs = ref([]);

// 获取Vuex中的当前播放状态
const store = useStore();

// 从数组中随机选择n个元素
function getRandomItems(array, n) {
  if (!array || array.length === 0) return [];
  const shuffled = [...array].sort(() => 0.5 - Math.random());
  return shuffled.slice(0, n);
}

// 获取所有歌单
async function getAllSongLists() {
  try {
    const res = await HttpManager.getSongList();
    if (res.success) {
      allSongLists.value = res.data || [];
      refreshSongList();
    }
  } catch (error) {
    console.error('获取歌单失败:', error);
  }
}

// 刷新显示的歌单
function refreshSongList() {
  songList.value = getRandomItems(allSongLists.value, 8);
}

// 获取所有歌手
async function getAllSingers() {
  try {
    const res = await HttpManager.getAllSinger();
    if (res.success) {
      allSingers.value = res.data || [];
      refreshSingerList();
    }
  } catch (error) {
    console.error('获取歌手失败:', error);
  }
}

// 刷新显示的歌手
function refreshSingerList() {
  singerList.value = getRandomItems(allSingers.value, 8);
}

// 获取所有歌曲
async function getAllSongs() {
  try {
    const res = await HttpManager.getAllSong();
    if (res.success) {
      allSongs.value = res.data || [];
      console.log("成功获取所有歌曲，数量：", allSongs.value.length);
    }
  } catch (error) {
    console.error('获取所有歌曲失败:', error);
  }
}

// 随机播放一首歌
async function playRandomSong() {
  try {
    // 如果还没有获取歌曲列表，先获取
    if (allSongs.value.length === 0) {
      await getAllSongs();
    }
    
    // 检查是否有歌曲可播放
    if (allSongs.value && allSongs.value.length > 0) {
      // 过滤出有效的歌曲（必须有url字段且不为空）
      const validSongs = allSongs.value.filter(song => song && song.url && song.url.trim() !== '');
      
      if (validSongs.length === 0) {
        console.error('没有找到有效的歌曲');
        return;
      }
      
      // 随机选择一首歌曲
      const randomIndex = Math.floor(Math.random() * validSongs.length);
      const song = validSongs[randomIndex];
      
      console.log('准备播放歌曲:', song);
      
      // 直接播放音乐，不再进行预检查
      playMusic({
        id: song.id,
        url: song.url,
        pic: song.pic || '/img/songPic/tubiao.jpg',
        index: randomIndex,
        name: song.name || '未知歌曲',
        lyric: song.lyric || '',
        introduction: song.introduction || '',
        currentSongList: validSongs,
      });
    }
  } catch (error) {
    console.error('随机播放失败:', error);
  }
}

// 处理搜索
function handleSearch() {
  if (searchKeyword.value.trim()) {
    router.push({
      path: '/search',
      query: { keywords: searchKeyword.value }
    });
  }
}

// 组件挂载时初始化
onMounted(async () => {
  changeIndex(NavName.Home);
  await Promise.all([
    getAllSongLists(),
    getAllSingers(),
    getAllSongs() // 添加获取所有歌曲
  ]);
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.home-container {
  padding: 20px 40px;
  background-color: #fafafa;
  min-height: calc(100vh - #{$header-height} - #{$play-bar-height});
}

/* 横幅 */
.simple-banner {
  position: relative;
  height: 400px;
  margin-bottom: 40px;
  border-radius: 12px;
  overflow: hidden;
  background: linear-gradient(135deg, #bbdefb, #90caf9, #64b5f6);
  border: 1px solid rgba(0, 0, 0, 0.03);
  backdrop-filter: blur(10px);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
  transition: all 0.3s ease;
  
  &:hover {
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    transform: translateY(-2px);
  }
  
  .banner-content {
    position: relative;
    z-index: 2;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    padding: 0 20px;
    text-align: center;
    color: white;
    
    .banner-title {
      font-size: 3.5rem;
      font-weight: 700;
      margin-bottom: 1rem;
      text-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
    }
    
    .banner-subtitle {
      font-size: 1.5rem;
      margin-bottom: 2rem;
      opacity: 0.9;
      text-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
    }
    
    .search-container {
      width: 100%;
      max-width: 800px;
      margin-bottom: 2rem;
      
      .search-box {
        margin: 0 auto;
        width: 750px;
        display: flex;
        align-items: center;
        justify-content: center;
      }

      .search-left {
        width: 80%;
        height: 50px;
        border: #90caf9 1px solid;
        margin-top: 20px;
        border-bottom-left-radius: 25px;
        border-top-left-radius: 25px;
        outline: none;
        text-indent: 20px;
        background-color: rgba(255, 255, 255, 0.9);
        color: rgba(0, 0, 0, 0.85);
        font-size: 1rem;
        transition: all 0.3s ease;

        &::placeholder {
          color: rgba(0, 0, 0, 0.45);
        }

        &:hover, &:focus {
          background-color: #fff;
          border-color: #64b5f6;
        }
      }

      .search-right {
        width: 19%;
        height: 50px;
        background: #90caf9;
        color: #fff;
        border: none;
        margin-top: 20px;
        border-bottom-right-radius: 25px;
        border-top-right-radius: 25px;
        outline: none;
        cursor: pointer;
        font-size: 1rem;
        transition: all 0.3s ease;

        &:hover {
          background: #64b5f6;
          transform: translateY(-1px);
        }

        &:active {
          transform: translateY(1px);
        }
      }

      @media screen and (max-width: $sm) {
        .search-box {
          width: 100%;
        }
      }
    }
    
    .music-controls {
      .control-btn {
        background: rgba(255, 255, 255, 0.2);
        color: white;
        border: 2px solid rgba(255, 255, 255, 0.5);
        border-radius: 25px;
        padding: 10px 25px;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease;
        display: flex;
        align-items: center;
        justify-content: center;
        
        i {
          margin-right: 8px;
          font-size: 1.2rem;
        }
        
        &:hover {
          background: rgba(255, 255, 255, 0.3);
          transform: translateY(-2px);
        }
        
        &:active {
          transform: translateY(1px);
        }
      }
      
      .play-random-btn {
        background: rgba(100, 181, 246, 0.8);
        border-color: rgba(100, 181, 246, 0.8);
        
        &:hover {
          background: rgba(100, 181, 246, 0.9);
        }
      }
    }
  }
}

/*内容区域*/
.content-section {
  .section-container {
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 30px;
    border: 1px solid rgba(0, 0, 0, 0.03);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    backdrop-filter: blur(10px);
    transition: all 0.3s ease;
    
    &:hover {
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
      transform: translateY(-2px);
    }
    
    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      
      .section-title {
        font-size: 24px;
        font-weight: 600;
        color: rgba(0, 0, 0, 0.85);
        margin: 0;
        position: relative;
        
        &:before {
          content: '';
          position: absolute;
          left: 0;
          bottom: -8px;
          width: 30px;
          height: 3px;
          background-color: $color-blue-active;
          border-radius: 3px;
          transition: width 0.3s ease;
        }
      }
      
      .refresh-btn {
        background: transparent;
        border: 1px solid rgba(0, 0, 0, 0.08);
        border-radius: 20px;
        padding: 8px 16px;
        display: flex;
        align-items: center;
        font-size: 14px;
        color: rgba(0, 0, 0, 0.65);
        cursor: pointer;
        transition: all 0.3s ease;
        
        i {
          font-size: 16px;
          margin-right: 6px;
        }
        
        &:hover {
          background-color: rgba(144, 202, 249, 0.1);
          color: $color-blue-active;
          border-color: $color-blue-active;
          transform: translateY(-1px);
        }
        
        &:active {
          transform: translateY(1px);
        }
      }
    }
    
    .play-list-container {
      :deep(.el-card) {
        border: none;
        border-radius: 8px;
        transition: all 0.3s ease;
        overflow: hidden;
        
        &:hover {
          transform: translateY(-5px);
          box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
          
          .el-card__body {
            .play-list-name {
              color: $color-blue-active;
            }
          }
        }
        
        .el-card__body {
          padding: 12px;
          
          .play-list-name {
            font-size: 14px;
            color: rgba(0, 0, 0, 0.85);
            transition: color 0.3s ease;
          }
        }
      }
    }
  }
}

@media screen and (max-width: $sm) {
  .home-container {
    padding: 15px;
  }
  
  .simple-banner {
    height: 300px;
    
    .banner-content {
      .banner-title {
        font-size: 2rem;
      }
      
      .banner-subtitle {
        font-size: 1.2rem;
      }
      
      .search-container {
        max-width: 90%;
      }
    }
  }
  
  .content-section {
    .section-container {
      padding: 16px;
      
      .section-header {
        .section-title {
          font-size: 20px;
        }
      }
    }
  }
}
</style>
