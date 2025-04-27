<template>
  <div class="fluent-sidebar">
    <el-menu
      class="fluent-menu"
      :background-color="variables.fluentBackground"
      :text-color="variables.fluentTextPrimary"
      :active-text-color="variables.fluentPrimary"
      default-active="2"
      router
      :collapse="collapse"
    >
      <el-menu-item index="info" class="fluent-menu-item">
        <el-icon><pie-chart /></el-icon>
        <span>系统首页</span>
      </el-menu-item>
      <el-menu-item index="consumer" class="fluent-menu-item">
        <el-icon><User /></el-icon>
        <span>用户管理</span>
      </el-menu-item>
      <el-menu-item index="singer" class="fluent-menu-item">
        <el-icon><mic /></el-icon>
        <span>歌手管理</span>
      </el-menu-item>
      <el-menu-item index="song-manage" class="fluent-menu-item">
        <el-icon><headset /></el-icon>
        <span>歌曲管理</span>
      </el-menu-item>
      <el-menu-item index="songList" class="fluent-menu-item">
        <el-icon><Document /></el-icon>
        <span>歌单管理</span>
      </el-menu-item>
    </el-menu>
  </div>
</template>

<script lang="ts" setup>
import { ref, reactive } from "vue";
import { PieChart, Mic, Document, User, Headset } from "@element-plus/icons-vue";
import emitter from "@/utils/emitter";

const collapse = ref(false);
emitter.on("collapse", (msg) => {
  collapse.value = msg as boolean;
});

// CSS变量映射，便于在JS中访问
const variables = reactive({
  fluentBackground: 'var(--fluent-background)',
  fluentTextPrimary: 'var(--fluent-text-primary)',
  fluentPrimary: 'var(--fluent-primary)',
});
</script>

<style scoped>
.fluent-sidebar {
  display: block;
  position: absolute;
  left: 0;
  top: 60px;
  bottom: 0;
  overflow-y: scroll;
  box-shadow: var(--fluent-box-shadow);
  background-color: var(--fluent-background);
  transition: var(--fluent-transition);
  z-index: 99;
}

.fluent-sidebar::-webkit-scrollbar {
  width: 0;
}

.fluent-sidebar > ul {
  height: 100%;
  border-right: none;
}

.fluent-menu:not(.el-menu--collapse) {
  width: 150px;
}

.fluent-menu-item {
  font-family: var(--fluent-font-family);
  height: 50px;
  line-height: 50px;
  transition: var(--fluent-transition);
}

.fluent-menu-item:hover {
  background-color: var(--fluent-secondary-hover) !important;
}

.fluent-menu-item.is-active {
  background-color: rgba(0, 120, 212, 0.05) !important;
  border-left: 3px solid var(--fluent-primary);
}

.el-menu-item [class^="el-icon-"] {
  color: var(--fluent-primary);
  margin-right: 10px;
}
</style>
