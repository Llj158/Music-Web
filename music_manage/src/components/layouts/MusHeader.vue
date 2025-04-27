<template>
  <div class="fluent-header">
    <div class="fluent-collapse-btn" @click="collapseChage">
      <el-icon v-if="!collapse"><expand /></el-icon>
      <el-icon v-else><fold /></el-icon>
    </div>
    <div class="fluent-logo">{{ nusicName }}</div>
    <div class="fluent-header-right">
      <div class="fluent-header-user">
        <div class="fluent-user-avatar">
          <img :src="attachImageUrl(userPic)" />
        </div>
        <el-dropdown class="fluent-username" trigger="click" @command="handleCommand">
          <span class="el-dropdown-link">
            {{ username }}
            <i class="el-icon-caret-bottom"></i>
          </span>
          <template #dropdown>
            <el-dropdown-menu>
              <el-dropdown-item command="loginout">退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </template>
        </el-dropdown>
      </div>
    </div>
  </div>
</template>
<script lang="ts">
import { defineComponent, computed, ref, onMounted } from "vue";
import { useStore } from "vuex";
import mixin from "@/mixins/mixin";
import { Expand, Fold } from "@element-plus/icons-vue";
import emitter from "@/utils/emitter";
import { HttpManager } from "@/api";
import { RouterName, MUSICNAME } from "@/enums";

export default defineComponent({
  components: {
    Expand,
    Fold,
  },
  setup() {
    const { routerManager } = mixin();
    const store = useStore();

    const collapse = ref(true);
    const username = computed(() => store.getters.username);
    const userPic = computed(() => store.getters.userPic);
    const nusicName = ref(MUSICNAME);

    onMounted(() => {
      if (document.body.clientWidth < 1500) {
        collapseChage();
      }
    });

    // 侧边栏折叠
    function collapseChage() {
      collapse.value = !collapse.value;
      emitter.emit("collapse", collapse.value);
    }
    // 用户名下拉菜单选择事件
    function handleCommand(command) {
      if (command === "loginout") {
        localStorage.removeItem('admin_token');
        localStorage.removeItem('adminId');
        store.commit('setUsername', '');
        store.commit('setId', '');
        routerManager(RouterName.SignIn, { path: RouterName.SignIn });
      }
    }
    return {
      nusicName,
      username,
      userPic,
      collapse,
      collapseChage,
      handleCommand,
      attachImageUrl: HttpManager.attachImageUrl,
    };
  },
});
</script>
<style scoped>
.fluent-header {
  position: absolute;
  z-index: 100;
  width: 100%;
  height: 60px;
  display: flex;
  align-items: center;
  font-size: var(--fluent-font-size-large);
  color: var(--fluent-text-primary);
  background: var(--fluent-background);
  box-shadow: var(--fluent-box-shadow);
  transition: var(--fluent-transition);
}

.fluent-collapse-btn {
  display: flex;
  padding: 0 21px;
  cursor: pointer;
  color: var(--fluent-primary);
  transition: var(--fluent-transition);
}

.fluent-collapse-btn:hover {
  color: var(--fluent-primary-hover);
  transform: scale(1.1);
}

.fluent-logo {
  width: 250px;
  font-weight: var(--fluent-font-weight-bold);
  color: var(--fluent-primary);
}

.fluent-header-right {
  position: absolute;
  right: 0;
  padding-right: 30px;
}

.fluent-header-user {
  display: flex;
  align-items: center;
}

.fluent-username {
  margin-left: 10px;
  font-family: var(--fluent-font-family);
  color: var(--fluent-text-primary);
}

.fluent-user-avatar img {
  display: block;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  box-shadow: var(--fluent-box-shadow);
  transition: var(--fluent-transition);
}

.fluent-user-avatar img:hover {
  box-shadow: var(--fluent-box-shadow-hover);
  transform: scale(1.05);
}

.el-dropdown-link {
  cursor: pointer;
}

.el-dropdown-menu__item {
  text-align: center;
  font-family: var(--fluent-font-family);
}
</style>
