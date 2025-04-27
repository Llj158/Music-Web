<template>
  <div class="setting">
    <div class="setting-container">
      <h1 class="setting-title">设置</h1>
      <el-tabs tab-position="left" class="setting-tabs">
        <el-tab-pane label="个人资料" class="content">
          <Personal-data></Personal-data>
        </el-tab-pane>
        <el-tab-pane label="更改密码" class="content">
          <Password></Password>
        </el-tab-pane>
        <el-tab-pane label="账号和安全" class="content">
          <div class="dangerous-actions">
            <h3>危险操作</h3>
            <p class="warning-text">注销账号后，您的所有数据将被删除，且无法恢复。</p>
            <el-button type="danger" class="delete-button" @click="cancelAccount">
              <span>注销账号</span>
            </el-button>
          </div>
        </el-tab-pane>
      </el-tabs>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, computed, reactive } from "vue";
import { Delete } from "@element-plus/icons-vue";
import PersonalData from "./PersonalData.vue";
import Password from "./Password.vue";
import { HttpManager } from "@/api";
import { useStore } from "vuex";
import mixin from "@/mixins/mixin";
import { RouterName } from "@/enums";
import { ElMessageBox } from 'element-plus';

export default defineComponent({
  components: {
    PersonalData,
    Password,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();
    const { routerManager } = mixin();

    const userId = computed(() => store.getters.userId);

    async function cancelAccount() {
      ElMessageBox.confirm('此操作将永久删除您的账号，是否继续?', '警告', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning',
        customClass: 'fluent-confirm-modal'
      }).then(async () => {
        const result = (await HttpManager.deleteUser(userId.value)) as ResponseBody;
        (proxy as any).$message({
          message: result.message,
          type: result.type,
          customClass: 'fluent-message'
        });
        routerManager(RouterName.SignIn, { path: RouterName.SignIn });
        proxy.$store.commit("setToken", false);
      }).catch(() => {
        (proxy as any).$message({
          type: 'info',
          message: '已取消注销操作',
          customClass: 'fluent-message'
        });
      });
    }

    return {
      Delete,
      cancelAccount,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";
@import "@/assets/css/global.scss";

.setting {
  min-height: calc(100vh - #{$header-height} - #{$play-bar-height});
  background-color: #fafafa;
  padding: 40px;
  
  @media screen and (max-width: $sm) {
    padding: 20px;
  }
}

.setting-container {
  max-width: 1000px;
  margin: 0 auto;
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(0, 0, 0, 0.03);
  overflow: hidden;
}

.setting-title {
  font-size: 24px;
  font-weight: 600;
  color: rgba(0, 0, 0, 0.85);
  padding: 20px 30px;
  margin: 0;
  border-bottom: 1px solid rgba(0, 0, 0, 0.06);
}

.setting-tabs {
  padding: 20px;
  
  :deep(.el-tabs__header) {
    margin-right: 30px;
    border-right: 1px solid rgba(0, 0, 0, 0.06);
    
    .el-tabs__nav {
      border: none;
    }
    
    .el-tabs__item {
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      padding: 15px 20px;
      color: rgba(0, 0, 0, 0.65);
      font-size: 15px;
      transition: all 0.3s ease;
      border-radius: 8px;
      margin: 5px 0;
      height: 50px;
      width: 110px;
      
      &:hover {
        background-color: rgba(0, 120, 212, 0.05);
        color: rgba(0, 0, 0, 0.85);
      }
      
      &.is-active {
        color: $color-blue-active;
        background-color: rgba(0, 120, 212, 0.1);
        font-weight: 500;
        
        &:hover {
          background-color: rgba(0, 120, 212, 0.15);
        }
      }
    }
  }
  
  :deep(.el-tabs__content) {
    padding: 10px 20px;
  }
}

.content {
  padding-top: 20px;
}

.dangerous-actions {
  padding: 30px;
  background-color: rgba(244, 67, 54, 0.03);
  border-radius: 10px;
  border: 1px solid rgba(244, 67, 54, 0.1);
  margin-top: 20px;
  text-align: left;
  
  h3 {
    color: rgba(0, 0, 0, 0.85);
    margin-top: 0;
    font-size: 18px;
  }
  
  .warning-text {
    color: rgba(0, 0, 0, 0.65);
    margin-bottom: 30px;
  }
  
  .delete-button {
    background-color: #d13438;
    border: none;
    box-shadow: 0 2px 8px rgba(209, 52, 56, 0.25);
    padding: 10px 24px;
    transition: all 0.3s ease;
    
    &:hover {
      background-color: #e44146;
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(209, 52, 56, 0.35);
    }
    
    &:active {
      transform: translateY(0);
    }
    
  }
}
</style>
