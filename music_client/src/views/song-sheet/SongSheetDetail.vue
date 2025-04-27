<template>
  <div class="songsheet-detail-container" v-if="songDetails">
    <div class="songsheet-detail-content">
      <aside class="songsheet-sidebar">
        <div class="songsheet-image-container">
          <el-image class="songsheet-img" fit="cover" :src="attachImageUrl(songDetails.pic)" />
          <div class="image-backdrop"></div>
        </div>
        <div class="songsheet-info-card">
          <h2 class="info-title">歌单信息</h2>
          <h3 class="songsheet-title">{{ songDetails.title }}</h3>
          <div class="score-section">
            <div class="score-item">
              <span class="score-label">歌单评分</span>
              <div class="score-value">
                <el-rate v-model="rank" allow-half disabled></el-rate>
                <span class="score-number">{{ (rank * 2).toFixed(1) }}</span>
              </div>
            </div>
            <div class="score-item user-score">
              <span class="score-label">{{ score ? '您的评分：' + (score * 2).toFixed(1) + '分' : '请评分' }}</span>
              <div class="score-value">
                <el-rate allow-half v-model="score" @click="pushValue()"></el-rate>
              </div>
            </div>
          </div>
        </div>
      </aside>
      
      <main class="songsheet-main-content">
        <div class="songsheet-header">
          <h1 class="songsheet-name">简介</h1>
          <p class="songsheet-description">{{ songDetails.introduction }}</p>
        </div>
        
        <div class="songs-container">
          <div class="section-header">
            <h2 class="section-title">歌曲列表</h2>
          </div>
          <song-list class="album-body" :songList="currentSongList"></song-list>
        </div>
        
        <div class="comment-container">
          <div class="section-header">
            <h2 class="section-title">评论</h2>
          </div>
          <comment :playId="songListId" :type="1"></comment>
        </div>
      </main>
    </div>
  </div>
  <div v-else class="loading-container">
    <el-empty description="加载中..." v-loading="true"></el-empty>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, computed, getCurrentInstance, onMounted } from "vue";
import { useStore } from "vuex";
import { useRouter, useRoute } from "vue-router";
import { ElMessage } from "element-plus";
import { HttpManager } from "@/api";
import mixin from "@/mixins/mixin";
import SongList from "@/components/SongList.vue";
import Comment from "@/components/Comment.vue";

interface ResponseBody {
  code: number;
  success: boolean;
  message: string;
  type: string;
  data: any;
}

interface SongListItem {
  id: number;
  title: string;
  pic: string;
  introduction: string;
  style: string;
}

export default defineComponent({
  components: {
    SongList,
    Comment,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();
    const router = useRouter();
    const route = useRoute();
    const { checkStatus } = mixin();

    const currentSongList = ref([]); // 存放的音乐
    const nowSongListId = ref(""); // 歌单 ID
    const nowScore = ref(0);
    const nowRank = ref(0);
    const assistText = ref("评价");
    const songDetails = computed(() => store.getters.songDetails); // 单个歌单信息
    const nowUserId = computed(() => store.getters.userId);

    // 从路由参数获取歌单ID
    const routeId = route.params.id as string;
    nowSongListId.value = routeId;

    // 初始化数据
    async function initData() {
      try {
        // 如果store中没有歌单信息，则从服务器获取
        if (!songDetails.value) {
          const result = (await HttpManager.getSongList()) as ResponseBody;
          if (result.success) {
            const songList = (result.data as SongListItem[]).find(item => item.id === Number(routeId));
            if (songList) {
              store.commit('setSongDetails', songList);
              nowSongListId.value = songList.id.toString();
            } else {
              ElMessage.error('未找到该歌单');
              router.push('/404');
              return;
            }
          }
        } else {
          nowSongListId.value = songDetails.value.id.toString();
        }

        // 并行加载评分和歌曲列表
        await Promise.all([
          getUserRank(nowUserId.value, nowSongListId.value),
          getRank(nowSongListId.value),
          getSongId(nowSongListId.value)
        ]);
      } catch (error) {
        console.error('初始化数据失败:', error);
        ElMessage.error('加载数据失败，请刷新重试');
      }
    }

    onMounted(() => {
      initData();
    });
  
    // 收集歌单里面的歌曲
    async function getSongId(id) {
      if (!id) return;
      try {
        const result = (await HttpManager.getListSongOfId(id)) as ResponseBody;
        if (result.success && result.data) {
          currentSongList.value = [];
          // 并行获取所有歌曲信息
          const songPromises = result.data.map(item => 
            HttpManager.getSongOfId(item.songId)
          );
          const songResults = await Promise.all(songPromises);
          currentSongList.value = songResults
            .filter(result => result.success && result.data?.[0])
            .map(result => result.data[0]);
        }
      } catch (error) {
        console.error('获取歌曲列表失败:', error);
        throw error;
      }
    }

    // 获取评分
    async function getRank(id) {
      if (!id) return;
      try {
        const result = (await HttpManager.getRankOfSongListId(id)) as ResponseBody;
        nowRank.value = result.data ? Number(Number(result.data).toFixed(1)) / 2 : 0;
      } catch (error) {
        console.error('获取评分失败:', error);
        throw error;
      }
    }

    async function getUserRank(userId, songListId) {
      if (!userId || !songListId) return;
      try {
        const result = (await HttpManager.getUserRank(userId, songListId)) as ResponseBody;
        if (result.data !== null && result.data !== undefined) {
          nowScore.value = Number(Number(result.data).toFixed(1)) / 2;
        } else {
          nowScore.value = 0;
        }
      } catch (error) {
        console.error('获取用户评分失败:', error);
        throw error;
      }
    }

    // 提交评分
    async function pushValue() {
      if (!checkStatus()) return;

      const songListId = nowSongListId.value;
      var consumerId = nowUserId.value;
      const score = nowScore.value*2;
      try {
        const result = (await HttpManager.setRank({songListId,consumerId,score})) as ResponseBody;
        if (result.success) {
          getRank(nowSongListId.value);
          (proxy as any).$message({
            message: "评分成功",
            type: "success",
          });
        } else {
          (proxy as any).$message({
            message: result.message || "评分失败",
            type: "error",
          });
        }
      } catch (error) {
        console.error(error);
        (proxy as any).$message({
          message: "评分失败",
          type: "error",
        });
      }
    }

    return {
      songDetails,
      rank: nowRank,
      score: nowScore,
      assistText,
      currentSongList,
      songListId: nowSongListId,
      attachImageUrl: HttpManager.attachImageUrl,
      pushValue,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.songsheet-detail-container {
  padding: 20px 40px;
  background-color: #fafafa;
  min-height: calc(100vh - #{$header-height} - #{$play-bar-height});
  margin-top: 0;
}

.songsheet-detail-content {
  display: flex;
  gap: 40px;
}

.songsheet-sidebar {
  width: 340px;
  
  .songsheet-image-container {
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
      
      .songsheet-img {
        transform: scale(1.05);
      }
    }
    
    .songsheet-img {
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
  
  .songsheet-info-card {
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
    
    .songsheet-title {
      font-size: 18px;
      font-weight: 500;
      color: rgba(0, 0, 0, 0.85);
      margin-bottom: 20px;
    }
    
    .score-section {
      .score-item {
        margin-bottom: 16px;
        
        .score-label {
          display: block;
          font-size: 14px;
          color: rgba(0, 0, 0, 0.65);
          margin-bottom: 8px;
        }
        
        .score-value {
          display: flex;
          align-items: center;
          
          .score-number {
            margin-left: 12px;
            font-size: 24px;
            font-weight: 600;
            color: $color-blue-active;
          }
        }
        
        &.user-score {
          margin-top: 24px;
          padding-top: 16px;
          border-top: 1px solid rgba(0, 0, 0, 0.05);
        }
      }
    }
  }
}

.songsheet-main-content {
  flex: 1;
  
  .songsheet-header {
    margin-bottom: 30px;
    
    .songsheet-name {
      font-size: 28px;
      font-weight: 600;
      color: rgba(0, 0, 0, 0.85);
      margin-bottom: 16px;
    }
    
    .songsheet-description {
      color: rgba(0, 0, 0, 0.65);
      font-size: 16px;
      line-height: 1.6;
    }
  }
  
  .songs-container, .comment-container {
    background-color: rgba(255, 255, 255, 0.8);
    border-radius: 12px;
    padding: 24px;
    border: 1px solid rgba(0, 0, 0, 0.03);
    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
    backdrop-filter: blur(10px);
    transition: all 0.3s ease;
    margin-bottom: 30px;
    
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
  .songsheet-detail-container {
    padding: 15px;
  }
  
  .songsheet-detail-content {
    flex-direction: column;
    gap: 20px;
  }
  
  .songsheet-sidebar {
    width: 100%;
    
    .songsheet-image-container {
      .songsheet-img {
        height: 240px;
      }
    }
  }
  
  .songsheet-main-content {
    .songsheet-header {
      .songsheet-name {
        font-size: 24px;
      }
    }
    
    .songs-container, .comment-container {
      padding: 16px;
    }
  }
}
</style>
