<template>
  <div class="personal">
    <div class="personal-header">
      <div class="personal-header-content">
        <div class="personal-avatar" @click="dialogTableVisible = true">
          <el-image fit="cover" :src="attachImageUrl(userPic)"/>
          <div class="avatar-overlay">
            <el-icon><Edit /></el-icon>
          </div>
        </div>
        <div class="personal-info">
          <h1 class="username">{{ personalInfo.username }}</h1>
          <p class="introduction">{{ personalInfo.introduction || '还没有个人介绍...' }}</p>
          <el-button class="edit-button" type="primary" :icon="Edit" @click="goPage()">修改个人信息</el-button>
        </div>
      </div>
    </div>
    
    <div class="personal-body">
      <div class="collection-container">
        <div class="section-header">
          <h2 class="section-title">我的收藏</h2>
        </div>
        <div class="song-list-wrapper">
          <song-list :songList="collectSongList" :show="true" @changeData="changeData"></song-list>
          <div v-if="collectSongList.length === 0" class="empty-collection">
            <el-empty description="暂无收藏歌曲"></el-empty>
          </div>
        </div>
      </div>
    </div>
    
    <el-dialog 
      v-model="dialogTableVisible" 
      title="修改头像" 
      width="500px" 
      class="avatar-dialog"
      :modal-class="'fluent-dialog-modal'"
      :show-close="true"
      align-center
      destroy-on-close>
      <upload></upload>
      <template #footer>
        <div class="dialog-footer">
          <el-button @click="dialogTableVisible = false" class="cancel-button">取消</el-button>
          <el-button type="primary" @click="dialogTableVisible = false" class="confirm-button">完成</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { defineComponent, nextTick, ref, computed, watch, reactive } from "vue";
import { useStore } from "vuex";
import { Edit } from "@element-plus/icons-vue";
import SongList from "@/components/SongList.vue";
import Upload from "../setting/Upload.vue";
import mixin from "@/mixins/mixin";
import { HttpManager } from "@/api";
import { RouterName } from "@/enums";

export default defineComponent({
  components: {
    SongList,
    Upload,
  },
  setup() {
    const store = useStore();

    const { routerManager } = mixin();

    const dialogTableVisible = ref(false);
    const collectSongList = ref([]); // 收藏的歌曲
    const personalInfo = reactive({
      username: "",
      userSex: "",
      birth: "",
      location: "",
      introduction: "",
    });
    const userId = computed(() => store.getters.userId);
    const userPic = computed(() => store.getters.userPic);
    watch(userPic, () => {
      dialogTableVisible.value = false;
    });

    function goPage() {
      routerManager(RouterName.Setting, { path: RouterName.Setting });
    }
    async function getUserInfo(id) {
      const result = (await HttpManager.getUserOfId(id)) as ResponseBody;
      personalInfo.username = result.data[0].username;
      personalInfo.userSex = result.data[0].sex;
      personalInfo.birth = result.data[0].birth;
      personalInfo.introduction = result.data[0].introduction;
      personalInfo.location = result.data[0].location;
    }
    // 获取收藏的歌曲
    async function getCollection(userId) {
      collectSongList.value = []
      const result = (await HttpManager.getCollectionOfUser(userId)) as ResponseBody;
      const collectIDList = result.data || []; // 存放收藏的歌曲ID
      // 通过歌曲ID获取歌曲信息
      for (const item of collectIDList) {
        if (!item.songId) {
          console.error(`歌曲${item}异常`);
          continue;
        }

        const result = (await HttpManager.getSongOfId(item.songId)) as ResponseBody;
        collectSongList.value.push(result.data[0]);
      }
    }

    function changeData() {
      getCollection(userId.value);
    }

    nextTick(() => {
      getUserInfo(userId.value);
      getCollection(userId.value);
    });

    return {
      Edit,
      userPic,
      dialogTableVisible,
      collectSongList,
      personalInfo,
      attachImageUrl: HttpManager.attachImageUrl,
      goPage,
      changeData,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.personal {
  margin-top: 0;
  min-height: calc(100vh - #{$header-height} - #{$play-bar-height});
  background-color: #f8f9fa;
  position: relative;
  
  &::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    height: 200px;
    background: linear-gradient(to bottom, rgba(0, 0, 0, 0.02), transparent);
    pointer-events: none;
  }
}

.personal-header {
  background: linear-gradient(135deg, rgba(64, 169, 255, 0.8), rgba(0, 120, 212, 0.9));
  padding: 80px 40px 60px;
  position: relative;
  overflow: hidden;
  
  &::before {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    backdrop-filter: blur(20px);
    z-index: 0;
  }
  
  &::after {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
    opacity: 0.6;
    z-index: 1;
    animation: pulse 15s infinite linear;
  }
  
  .personal-header-content {
    position: relative;
    z-index: 2;
    display: flex;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    
    @media screen and (max-width: $sm) {
      flex-direction: column;
      text-align: center;
      gap: 20px;
    }
  }
}

@keyframes pulse {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}

.personal-avatar {
  width: 160px;
  height: 160px;
  border-radius: 50%;
  border: 4px solid rgba(255, 255, 255, 0.9);
  overflow: hidden;
  position: relative;
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  
  &:hover {
    transform: translateY(-5px) scale(1.02);
    box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
    
    .avatar-overlay {
      opacity: 1;
    }
  }
  
  :deep(.el-image) {
    width: 100%;
    height: 100%;
  }
  
  .avatar-overlay {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.4);
    display: flex;
    align-items: center;
    justify-content: center;
    opacity: 0;
    transition: opacity 0.3s ease;
    
    .el-icon {
      color: white;
      font-size: 30px;
      transform: scale(1);
      transition: transform 0.2s ease;
    }
    
    &:hover .el-icon {
      transform: scale(1.2);
    }
  }
  
  @media screen and (max-width: $sm) {
    margin: 0 auto;
    width: 140px;
    height: 140px;
  }
}

.personal-info {
  margin-left: 40px;
  color: white;
  
  .username {
    font-size: 38px;
    font-weight: 600;
    margin: 0 0 8px 0;
    text-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    letter-spacing: -0.5px;
  }
  
  .introduction {
    font-size: 16px;
    margin: 0 0 25px 0;
    opacity: 0.9;
    max-width: 600px;
    line-height: 1.5;
    font-weight: 300;
  }
  
  .edit-button {
    background-color: rgba(255, 255, 255, 0.9);
    color: $color-blue-active;
    border: none;
    padding: 10px 20px;
    font-weight: 500;
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
    
    &:hover {
      background-color: white;
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }
    
    &:active {
      transform: translateY(0);
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
  }
  
  @media screen and (max-width: $sm) {
    margin-left: 0;
    
    .username {
      font-size: 30px;
    }
    
    .introduction {
      margin-bottom: 20px;
    }
  }
}

.personal-body {
  padding: 50px 40px;
  max-width: 1200px;
  margin: 0 auto;
  
  @media screen and (max-width: $sm) {
    padding: 30px 20px;
  }
}

.collection-container {
  background-color: rgba(255, 255, 255, 0.95);
  border-radius: 12px;
  padding: 30px;
  border: 1px solid rgba(0, 0, 0, 0.04);
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(10px);
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  
  &:hover {
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
    transform: translateY(-3px);
  }
  
  .section-header {
    margin-bottom: 30px;
    
    .section-title {
      font-size: 24px;
      font-weight: 600;
      color: rgba(0, 0, 0, 0.85);
      position: relative;
      
      &:after {
        content: '';
        position: absolute;
        left: 0;
        bottom: -12px;
        width: 40px;
        height: 3px;
        background-color: $color-blue-active;
        border-radius: 3px;
        transition: width 0.3s ease;
      }
    }
    
    &:hover .section-title:after {
      width: 60px;
    }
  }
  
  .song-list-wrapper {
    position: relative;
    
    &::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 40px;
      background: linear-gradient(to bottom, rgba(255, 255, 255, 0.9), transparent);
      pointer-events: none;
      z-index: 1;
      opacity: 0;
      transition: opacity 0.3s ease;
    }
    
    &::after {
      content: '';
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      height: 40px;
      background: linear-gradient(to top, rgba(255, 255, 255, 0.9), transparent);
      pointer-events: none;
      z-index: 1;
      opacity: 0;
      transition: opacity 0.3s ease;
    }
    
    &:hover {
      &::before, &::after {
        opacity: 1;
      }
    }
  }
  
  .empty-collection {
    padding: 50px 0;
    
    :deep(.el-empty) {
      padding: 20px;
      
      .el-empty__image {
        width: 120px;
      }
      
      .el-empty__description {
        margin-top: 20px;
        color: rgba(0, 0, 0, 0.5);
      }
    }
  }
}

.avatar-dialog {
  :deep(.el-dialog) {
    border-radius: 10px;
    overflow: hidden;
    box-shadow: 0 12px 32px 4px rgba(0, 0, 0, 0.1), 0 32px 64px 8px rgba(0, 0, 0, 0.05);
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255, 255, 255, 0.2);
  }

  :deep(.el-dialog__header) {
    padding: 20px 24px;
    margin: 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    background-color: rgba(250, 250, 250, 0.9);
  }
  
  :deep(.el-dialog__title) {
    font-weight: 600;
    font-size: 18px;
    color: rgba(0, 0, 0, 0.85);
  }
  
  :deep(.el-dialog__headerbtn) {
    top: 20px;
    
    .el-dialog__close {
      transition: all 0.2s ease;
      
      &:hover {
        transform: scale(1.1);
        color: $color-blue-active;
      }
    }
  }
  
  :deep(.el-dialog__body) {
    padding: 30px 24px;
    background-color: rgba(255, 255, 255, 0.95);
  }
  
  :deep(.el-dialog__footer) {
    padding: 16px 24px;
    border-top: 1px solid rgba(0, 0, 0, 0.05);
    background-color: rgba(250, 250, 250, 0.9);
  }
  
  .dialog-footer {
    display: flex;
    justify-content: flex-end;
    gap: 12px;
    
    .cancel-button {
      background: rgba(0, 0, 0, 0.03);
      border: none;
      transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
      
      &:hover {
        background: rgba(0, 0, 0, 0.08);
        transform: translateY(-2px);
      }
      
      &:active {
        transform: translateY(0);
      }
    }
    
    .confirm-button {
      background: $color-blue-active;
      border: none;
      transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
      box-shadow: 0 2px 5px rgba($color-blue-active, 0.2);
      
      &:hover {
        background: lighten($color-blue-active, 5%);
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba($color-blue-active, 0.3);
      }
      
      &:active {
        transform: translateY(0);
        box-shadow: 0 2px 5px rgba($color-blue-active, 0.2);
      }
    }
  }
}

:deep(.fluent-dialog-modal) {
  backdrop-filter: blur(12px);
  background-color: rgba(0, 0, 0, 0.4);
}
</style>
