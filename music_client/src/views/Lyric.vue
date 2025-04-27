<template>
  <div class="player-container">
    <!-- 左侧歌曲信息 -->
    <div class="song-info-container">
      <div class="song-info-content">
        <div class="song-image-wrapper">
          <el-image class="song-pic" fit="contain" :src="attachImageUrl(songPic)" />
          <div class="image-backdrop"></div>
        </div>
        <div class="song-details">
          <h2 class="song-title">{{ songTitle }}</h2>
          <div class="song-meta">
            <div class="meta-item">
              <span class="label">歌手：</span>
              <span class="value">{{ singerName }}</span>
            </div>
            <div class="meta-item" v-if="introduction">
              <span class="label">专辑：</span>
              <span class="value">{{ introduction }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- 右侧歌词和评论 -->
    <div class="lyric-comment-container">
      <div class="section lyric-section">
        <div class="section-header">
          <h3 class="section-title">歌词</h3>
          <div class="section-actions">
            <button class="action-btn">
              <i class="el-icon-document-copy"></i>
            </button>
          </div>
        </div>
        <div class="lyric-content" ref="lyricRef">
          <div class="lyric-wrapper" :style="{ transform: `translateY(${lrcTop}px)` }">
            <div v-if="lyricArr.length" class="has-lyric">
              <p 
                v-for="(item, index) in lyricArr" 
                :key="index"
                :class="{ 
                  'active': currentLyricIndex === index,
                  'translation': item[2] === 'translation',
                  'original': item[2] === 'original' || !item[2]
                }"
              >
                {{ item[1] }}
              </p>
            </div>
            <div v-else class="no-lyric">
              <span>暂无歌词</span>
            </div>
          </div>
        </div>
      </div>
      
      <div class="section comment-section">
        <div class="section-header">
          <h3 class="section-title">评论</h3>
          <div class="section-actions">
            <button class="action-btn">
              <i class="el-icon-refresh"></i>
            </button>
          </div>
        </div>
        <comment :playId="songId" :type="0"></comment>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { computed, defineComponent, ref, watch, onMounted } from "vue";
import { useStore } from "vuex";
import Comment from "@/components/Comment.vue";
import { parseLyric } from "@/utils";
import { HttpManager } from "@/api";
import { useRouter } from "vue-router";

export default defineComponent({
  components: {
    Comment,
  },
  setup() {
    const store = useStore();
    const router = useRouter();
    const lyricRef = ref<HTMLElement | null>(null);
    const currentLyricIndex = ref(-1);
    const lrcTop = ref(0);
    const lyricArr = ref([]);
    const songId = computed(() => store.getters.songId);
    const lyric = computed(() => store.getters.lyric);
    const currentPlayList = computed(() => store.getters.currentPlayList);
    const currentPlayIndex = computed(() => store.getters.currentPlayIndex);
    const curTime = computed(() => store.getters.curTime);
    const songTitle = computed(() => store.getters.songTitle);
    const singerName = computed(() => store.getters.singerName);
    const songPic = computed(() => store.getters.songPic);
    const introduction = computed(() => store.getters.introduction);

    // 页面加载时检查播放信息是否存在
    onMounted(() => {
      // 如果没有歌曲ID或播放列表为空，则返回上一页
      if (!songId.value || !currentPlayList.value || currentPlayList.value.length === 0) {
        console.log('播放信息丢失，返回上一页');
        router.go(-1); // 返回上一页
      }
    });

    watch(songId, () => {
      // 如果songId变为空或无效，返回上一页
      if (!songId.value) {
        router.go(-1);
        return;
      }
      
      lyricArr.value = parseLyric(currentPlayList.value[currentPlayIndex.value].lyric);
      currentLyricIndex.value = -1;
      lrcTop.value = 0;
    });

    watch(curTime, () => {
      if (lyricArr.value.length === 0) return;
      
      for (let i = 0; i < lyricArr.value.length; i++) {
        if (curTime.value < lyricArr.value[i][0]) {
          let targetIndex = i - 1;
          if (targetIndex >= 0 && lyricArr.value[targetIndex][2] === 'translation') {
            for (let j = targetIndex; j >= 0; j--) {
              if (lyricArr.value[j][2] === 'original' || !lyricArr.value[j][2]) {
                targetIndex = j;
                break;
              }
            }
          }
          
          currentLyricIndex.value = targetIndex;
          const containerHeight = 400;
          lrcTop.value = containerHeight / 2 - targetIndex * 32;
          break;
        }
        if (i === lyricArr.value.length - 1) {
          let targetIndex = i;
          if (lyricArr.value[targetIndex][2] === 'translation') {
            for (let j = targetIndex; j >= 0; j--) {
              if (lyricArr.value[j][2] === 'original' || !lyricArr.value[j][2]) {
                targetIndex = j;
                break;
              }
            }
          }
          
          currentLyricIndex.value = targetIndex;
          lrcTop.value = 200 - targetIndex * 32;
        }
      }
    });

    // 尝试加载歌词，如果失败则说明没有播放信息
    try {
      lyricArr.value = lyric.value ? parseLyric(lyric.value) : [];
    } catch (error) {
      console.error('加载歌词失败', error);
      // 加载失败时不立即跳转，让onMounted中的逻辑处理
    }

    return {
      lyricRef,
      lrcTop,
      lyricArr,
      currentLyricIndex,
      songId,
      songTitle,
      singerName,
      songPic,
      introduction,
      attachImageUrl: HttpManager.attachImageUrl,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.player-container {
  margin-top: 0;
  min-height: calc(100vh - #{$header-height} - #{$play-bar-height});
  display: flex;
  background-color: #fafafa;
}

.song-info-container {
  width: 400px;
  padding: 40px;
  border-right: 1px solid rgba(0, 0, 0, 0.06);
  background-color: rgba(255, 255, 255, 0.6);
  backdrop-filter: blur(10px);
  position: relative;
  z-index: 1;
  
  .song-info-content {
    position: sticky;
    top: $header-height + 40px;
    
    .song-image-wrapper {
      position: relative;
      width: 320px;
      height: 320px;
      margin: 0 auto;
      border-radius: 12px;
      overflow: hidden;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
      transition: all 0.3s ease;
      
      &:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
        
        .image-backdrop {
          opacity: 0.7;
        }
        
        .song-pic {
          transform: scale(1.05);
        }
      }
      
      .song-pic {
        width: 100%;
        height: 100%;
        transition: transform 0.5s ease;
        border-radius: 8px;
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
    
    .song-details {
      margin-top: 32px;
      padding: 0 10px;
      
      .song-title {
        font-size: 28px;
        font-weight: 600;
        color: rgba(0, 0, 0, 0.85);
        margin-bottom: 16px;
        transition: color 0.3s ease;
        
        &:hover {
          color: $color-blue-active;
        }
      }
      
      .song-meta {
        .meta-item {
          margin: 12px 0;
          font-size: 16px;
          
          .label {
            color: rgba(0, 0, 0, 0.45);
          }
          
          .value {
            color: rgba(0, 0, 0, 0.75);
            margin-left: 8px;
            transition: color 0.3s ease;
            
            &:hover {
              color: $color-blue-active;
            }
          }
        }
      }
    }
  }
}

.lyric-comment-container {
  flex: 1;
  padding: 40px;
  background-color: rgba(255, 255, 255, 0.5);
  backdrop-filter: blur(8px);
  
  .section {
    background-color: rgba(255, 255, 255, 0.9);
    border-radius: 12px;
    padding: 24px;
    margin-bottom: 30px;
    border: 1px solid rgba(0, 0, 0, 0.03);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
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
        font-size: 20px;
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
      
      .section-actions {
        .action-btn {
          background: none;
          border: none;
          width: 36px;
          height: 36px;
          border-radius: 50%;
          display: flex;
          align-items: center;
          justify-content: center;
          color: rgba(0, 0, 0, 0.5);
          cursor: pointer;
          transition: all 0.3s ease;
          
          &:hover {
            background-color: rgba(0, 0, 0, 0.05);
            color: $color-blue-active;
          }
          
          i {
            font-size: 18px;
          }
        }
      }
    }
  }
  
  .lyric-section {
    .lyric-content {
      height: 400px;
      overflow: hidden;
      position: relative;
      padding: 0 10px;
      
      &:before, &:after {
        content: '';
        position: absolute;
        left: 0;
        right: 0;
        height: 80px;
        pointer-events: none;
        z-index: 2;
      }
      
      &:before {
        top: 0;
        background: linear-gradient(to bottom, rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0));
      }
      
      &:after {
        bottom: 0;
        background: linear-gradient(to top, rgba(255, 255, 255, 0.95), rgba(255, 255, 255, 0));
      }
      
      .lyric-wrapper {
        position: absolute;
        left: 0;
        right: 0;
        transition: transform 0.6s cubic-bezier(0.23, 1, 0.32, 1);
      }
      
      .has-lyric {
        text-align: center;
        
        p {
          height: 32px;
          line-height: 32px;
          padding: 0;
          margin: 0;
          font-size: 14px;
          color: rgba(0, 0, 0, 0.45);
          transition: all 0.3s ease;
          cursor: default;
          
          &.translation {
            color: rgba(0, 0, 0, 0.35);
            font-size: 13px;
            font-style: italic;
          }
          
          &.active {
            color: $color-blue-active;
            font-size: 18px;
            font-weight: 500;
            transform: scale(1.05);
            letter-spacing: 0.5px;
          }
          
          &.translation.active {
            color: #65a4d8;
            font-size: 16px;
          }
          
          &:hover {
            color: $color-blue-active;
          }
        }
      }
      
      .no-lyric {
        display: flex;
        align-items: center;
        justify-content: center;
        height: 100%;
        color: rgba(0, 0, 0, 0.25);
        font-size: 16px;
      }
    }
  }
}

@media screen and (max-width: $sm) {
  .player-container {
    flex-direction: column;
  }
  
  .song-info-container {
    width: 100%;
    padding: 20px;
    border-right: none;
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);
    
    .song-info-content {
      position: relative;
      top: 0;
      
      .song-image-wrapper {
        width: 240px;
        height: 240px;
        margin: 0 auto;
      }
      
      .song-details {
        margin-top: 20px;
        
        .song-title {
          font-size: 22px;
          text-align: center;
        }
        
        .song-meta {
          text-align: center;
        }
      }
    }
  }
  
  .lyric-comment-container {
    padding: 20px;
    
    .section {
      padding: 20px;
      
      .section-header {
        .section-title {
          font-size: 18px;
        }
      }
    }
  }
}
</style>

