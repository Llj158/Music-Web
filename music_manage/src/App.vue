<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, onMounted } from "vue";
import { HttpManager } from "@/api";
import { RouterName } from "@/enums";
import { ElMessage } from 'element-plus'

export default defineComponent({
  setup() {
    const { proxy } = getCurrentInstance();

    // 检查是否需要自动登录
    const autoLogin = async () => {
      const token = localStorage.getItem('admin_token');
      if (token) {
        try {
          // 获取管理员信息
          const adminId = localStorage.getItem('adminId');
          if (adminId) {
            const result = (await HttpManager.getAdminOfId(parseInt(adminId))) as ResponseBody;
            if (result.success) {
              proxy.$store.commit("setUsername", result.data.name);
              proxy.$store.commit("setId", result.data.id);
            }
          }
        } catch (error) {
          console.error('自动登录失败:', error);
          // 如果获取管理员信息失败，清除token
          localStorage.removeItem('admin_token');
          localStorage.removeItem('adminId');
          ElMessage.warning('登录已过期，请重新登录');
          proxy.$router.push({ path: RouterName.SignIn });
        }
      }
    };

    onMounted(() => {
      autoLogin();
    });

    return {};
  },
});
</script>
