<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, onMounted } from "vue";
import { useRouter } from "vue-router";
import { HttpManager } from "@/api";
import { ElMessage } from "element-plus";
import { scrollToTop } from "@/utils";

export default defineComponent({
  setup() {
    const { proxy } = getCurrentInstance();
    const router = useRouter();

    // 检查是否需要自动登录
    const autoLogin = async () => {
      const token = localStorage.getItem('token');
      if (token) {
        try {
          // 获取用户信息
          const userId = localStorage.getItem('userId');
          if (userId) {
            const result = (await HttpManager.getUserOfId(parseInt(userId))) as ResponseBody;
            if (result.success) {
              proxy.$store.commit("setUserId", result.data[0].id);
              proxy.$store.commit("setUsername", result.data[0].username);
              proxy.$store.commit("setUserPic", result.data[0].avator);
              proxy.$store.commit("setToken", true);
            }
          }
        } catch (error) {
          console.error('自动登录失败:', error);
          // 如果获取用户信息失败，清除token
          ElMessage.warning('登录已过期，请重新登录');
          localStorage.removeItem('token');
          localStorage.removeItem('userId');
          proxy.$store.commit("setToken", false);
        }
      }
    };

    onMounted(() => {
      autoLogin();
      
      // 监听路由变化，确保页面滚动到顶部
      router.afterEach((to, from) => {
        // 使用 nextTick 确保DOM更新后再滚动
        proxy.$nextTick(() => {
          scrollToTop(true);
        });
      });
    });

    return {};
  },
});
</script>
