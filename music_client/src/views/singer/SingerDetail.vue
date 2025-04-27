<template>
  <div class="singer-detail-container" v-if="songDetails">
    <div class="singer-detail-content">
      <aside class="singer-sidebar">
        <div class="singer-image-container">
          <el-image class="singer-img" fit="cover" :src="attachImageUrl(songDetails.pic)" />
          <div class="image-backdrop"></div>
        </div>
        <div class="singer-info-card">
          <h2 class="info-title">基本资料</h2>
          <ul class="info-list">
            <li v-if="songDetails.sex !== 2" class="info-item">
              <span class="info-label">性别：</span>
              <span class="info-value">{{ getUserSex(songDetails.sex) }}</span>
            </li>
            <li class="info-item">
              <span class="info-label">生日：</span>
              <span class="info-value">{{ getBirth(songDetails.birth) }}</span>
            </li>
            <li class="info-item">
              <span class="info-label">故乡：</span>
              <span class="info-value">{{ songDetails.location }}</span>
            </li>
          </ul>
        </div>
      </aside>
      
      <main class="singer-main-content">
        <div class="singer-header">
          <h1 class="singer-name">{{ songDetails.name }}</h1>
          <p class="singer-description">{{ songDetails.introduction }}</p>
        </div>
        
        <div class="songs-container">
          <div class="section-header">
            <h2 class="section-title">歌曲列表</h2>
          </div>
          <song-list :songList="currentSongList"></song-list>
        </div>
      </main>
    </div>
  </div>
  <div v-else class="loading-container">
    <el-empty description="加载中..." v-loading="true"></el-empty>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, computed, onMounted } from "vue";
import { useStore } from "vuex";
import { useRoute, useRouter } from "vue-router";
import { ElMessage } from "element-plus";
import mixin from "@/mixins/mixin";
import SongList from "@/components/SongList.vue";
import { HttpManager } from "@/api";
import { getBirth } from "@/utils";

interface ResponseBody {
  code: number;
  success: boolean;
  message: string;
  type: string;
  data: any;
}

export default defineComponent({
  components: {
    SongList,
  },
  setup() {
    const store = useStore();
    const route = useRoute();
    const router = useRouter();
    const { getUserSex } = mixin();

    const currentSongList = ref([]);
    const songDetails = computed(() => store.getters.songDetails);

    // 初始化数据
    async function initData() {
      try {
        const singerId = route.params.id;
        
        // 先获取所有歌手信息
        const singerResult = (await HttpManager.getAllSinger()) as ResponseBody;
        if (singerResult.success) {
          const singer = singerResult.data.find(item => item.id === Number(singerId));
          if (singer) {
            store.commit('setSongDetails', singer);
            
            // 再获取歌手的歌曲列表
            const songsResult = (await HttpManager.getSongOfSingerId(singerId)) as ResponseBody;
            if (songsResult.success) {
              currentSongList.value = songsResult.data;
            } else {
              ElMessage.warning('获取歌曲列表失败');
            }
          } else {
            ElMessage.error('未找到该歌手');
            router.push('/404');
          }
        } else {
          ElMessage.error('获取歌手信息失败');
        }
      } catch (error) {
        console.error('初始化数据失败:', error);
        ElMessage.error('加载数据失败，请刷新重试');
      }
    }

    onMounted(() => {
      initData();
    });

    return {
      songDetails,
      currentSongList,
      attachImageUrl: HttpManager.attachImageUrl,
      getBirth,
      getUserSex,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.singer-detail-container {
  padding: 20px 40px;
  background-color: #fafafa;
  min-height: calc(100vh - #{$header-height} - #{$play-bar-height});
  margin-top: 0;
}

.singer-detail-content {
  display: flex;
  gap: 40px;
}

.singer-sidebar {
  width: 340px;
  
  .singer-image-container {
    position: relative;
    width: 100%;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
    margin-bottom: 24px;
    
    &:hover {
      .image-backdrop {
        opacity: 0.7;
      }
      
      .singer-img {
        transform: scale(1.05);
      }
    }
    
    .singer-img {
      width: 100%;
      height: 340px;
      object-fit: cover;
      transition: transform 0.5s ease;
      z-index: 2;
      position: relative;
    }
    
    .image-backdrop {
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, $color-blue-active, rgba(149, 210, 246, 0.5));
      opacity: 0;
      z-index: 1;
      transition: opacity 0.3s ease;
    }
  }
  
  .singer-info-card {
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 12px;
    padding: 24px;
    border: 1px solid rgba(0, 0, 0, 0.03);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    backdrop-filter: blur(10px);
    transition: all 0.3s ease;
    
    &:hover {
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
      transform: translateY(-2px);
    }
    
    .info-title {
      font-size: 20px;
      font-weight: 600;
      color: rgba(0, 0, 0, 0.85);
      margin-bottom: 20px;
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
    
    .info-list {
      .info-item {
        padding: 12px 0;
        border-bottom: 1px solid rgba(0, 0, 0, 0.05);
        display: flex;
        
        &:last-child {
          border-bottom: none;
        }
        
        .info-label {
          color: rgba(0, 0, 0, 0.45);
          width: 60px;
        }
        
        .info-value {
          color: rgba(0, 0, 0, 0.85);
          flex: 1;
        }
      }
    }
  }
}

.singer-main-content {
  flex: 1;
  
  .singer-header {
    margin-bottom: 30px;
    
    .singer-name {
      font-size: 36px;
      font-weight: 600;
      color: rgba(0, 0, 0, 0.85);
      margin-bottom: 16px;
    }
    
    .singer-description {
      color: rgba(0, 0, 0, 0.65);
      font-size: 16px;
      line-height: 1.6;
    }
  }
  
  .songs-container {
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 12px;
    padding: 24px;
    border: 1px solid rgba(0, 0, 0, 0.03);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    backdrop-filter: blur(10px);
    transition: all 0.3s ease;
    
    &:hover {
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
      transform: translateY(-2px);
    }
    
    .section-header {
      margin-bottom: 20px;
      
      .section-title {
        font-size: 20px;
        font-weight: 600;
        color: rgba(0, 0, 0, 0.85);
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
    }
  }
}

.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: calc(100vh - #{$header-height});
  margin-top: $header-height;
  background-color: #fafafa;
}

@media screen and (max-width: $sm) {
  .singer-detail-container {
    padding: 15px;
  }
  
  .singer-detail-content {
    flex-direction: column;
    gap: 20px;
  }
  
  .singer-sidebar {
    width: 100%;
    
    .singer-image-container {
      .singer-img {
        height: 240px;
      }
    }
  }
  
  .singer-main-content {
    .singer-header {
      .singer-name {
        font-size: 28px;
      }
    }
    
    .songs-container {
      padding: 16px;
    }
  }
}
</style>
