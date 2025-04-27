<template>
  <div class="upload">
    <div v-if="uploading" class="upload-loading">
      <el-progress type="circle" :percentage="uploadProgress" :stroke-width="6" :width="100">
        <template #default="{ percentage }">
          <span class="progress-text">{{ percentage }}%</span>
          <span class="progress-label">上传中</span>
        </template>
      </el-progress>
    </div>
    <el-upload 
      v-else
      drag 
      :http-request="customUpload" 
      :show-file-list="false" 
      :before-upload="beforeAvatarUpload"
      class="fluent-upload">
      <div class="upload-content">
        <el-icon class="upload-icon"><upload-filled /></el-icon>
        <div class="upload-text">将文件拖到此处或<span class="highlight">点击上传</span></div>
        <div class="upload-tip">支持 {{ uploadTypes.join("、") }} 格式，不超过2MB</div>
      </div>
    </el-upload>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, computed, getCurrentInstance } from "vue";
import { useStore } from "vuex";
import { UploadFilled } from "@element-plus/icons-vue";
import { HttpManager } from "@/api";

interface UploadResponse {
  success: boolean;
  message: string;
  type: string;
  data: string;
}

export default defineComponent({
  components: {
    UploadFilled,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();

    const uploadTypes = ref(["jpg", "jpeg", "png", "gif"]);
    const userId = computed(() => store.getters.userId);
    const uploading = ref(false);
    const uploadProgress = ref(0);

    async function customUpload({ file }) {
      uploading.value = true;
      uploadProgress.value = 0;
      
      // 模拟上传进度
      const progressInterval = setInterval(() => {
        if (uploadProgress.value < 90) {
          uploadProgress.value += Math.floor(Math.random() * 10) + 5;
        }
      }, 300);
      
      const formData = new FormData();
      formData.append('file', file);
      formData.append('id', userId.value);
      try {
        const response = await HttpManager.updateUserAvatar(formData) as UploadResponse;
        
        // 完成上传
        clearInterval(progressInterval);
        uploadProgress.value = 100;
        
        setTimeout(() => {
          uploading.value = false;
          
          if (response && response.success) {
            proxy.$store.commit("setUserPic", response.data);
            (proxy as any).$message({
              message: response.message || '头像上传成功',
              type: response.type || 'success',
              customClass: 'fluent-message'
            });
          } else {
            throw new Error(response?.message || '上传失败');
          }
        }, 500);
      } catch (error: any) {
        clearInterval(progressInterval);
        uploading.value = false;
        (proxy as any).$message.error(error.message || '上传失败');
      }
    }

    function beforeAvatarUpload(file) {
      const ltCode = 2;
      const isLt10M = file.size / 1024 / 1024;
      const isExistFileType = uploadTypes.value.includes(file.type.replace(/image\//, ""));

      if (isLt10M > ltCode || isLt10M <= 0) {
        (proxy as any).$message.error(`图片大小范围是 0~${ltCode}MB!`);
        return false;
      }
      if (!isExistFileType) {
        (proxy as any).$message.error(`图片只支持 ${uploadTypes.value.join("、")} 格式!`);
        return false;
      }

      return true;
    }

    return {
      uploadTypes,
      customUpload,
      beforeAvatarUpload,
      uploading,
      uploadProgress
    };
  },
});
</script>

<style lang="scss" scoped>
.upload {
  width: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 10px 0;
  min-height: 220px;
}

.upload-loading {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 220px;
  width: 100%;
  
  :deep(.el-progress) {
    .el-progress__text {
      display: flex;
      flex-direction: column;
      align-items: center;
    }
  }
  
  .progress-text {
    font-size: 20px;
    font-weight: 600;
    color: #0078d4;
  }
  
  .progress-label {
    font-size: 12px;
    color: rgba(0, 0, 0, 0.6);
    margin-top: 4px;
  }
}

.fluent-upload {
  width: 100%;
  
  :deep(.el-upload) {
    width: 100%;
  }
  
  :deep(.el-upload-dragger) {
    width: 100%;
    height: 220px;
    border: 2px dashed rgba(0, 120, 212, 0.3);
    border-radius: 8px;
    background-color: rgba(0, 120, 212, 0.03);
    transition: all 0.3s ease;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    
    &:hover {
      border-color: rgba(0, 120, 212, 0.6);
      background-color: rgba(0, 120, 212, 0.05);
      transform: translateY(-2px);
      box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
    }

    &:active {
      transform: translateY(0);
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
    }
  }
  
  .upload-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 20px;
  }
  
  .upload-icon {
    font-size: 48px;
    color: rgba(0, 120, 212, 0.7);
    margin-bottom: 16px;
    transition: transform 0.3s ease;

    :deep(.el-upload-dragger:hover) & {
      transform: translateY(-5px);
    }
  }
  
  .upload-text {
    font-size: 16px;
    color: rgba(0, 0, 0, 0.7);
    margin-bottom: 8px;
    
    .highlight {
      color: #0078d4;
      font-weight: 500;
    }
  }
  
  .upload-tip {
    font-size: 13px;
    color: rgba(0, 0, 0, 0.5);
  }
}
</style>
