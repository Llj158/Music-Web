<template>
  <el-container>
    <el-header>
      <page-header></page-header>
    </el-header>
    <el-main>
      <router-view />
      <current-play></current-play>
      <play-bar></play-bar>
      <scroll-top></scroll-top>
      <audio-player></audio-player>
    </el-main>
    <el-footer>
      <footer-content></footer-content>
    </el-footer>
  </el-container>
</template>

<script lang="ts" setup>
import { getCurrentInstance } from "vue";
import PageHeader from "@/components/layouts/Header.vue";
import CurrentPlay from "@/components/layouts/CurrentPlay.vue";
import PlayBar from "@/components/layouts/PlayBar.vue";
import ScrollTop from "@/components/layouts/ScrollTop.vue";
import FooterContent from "@/components/layouts/Footer.vue";
import AudioPlayer from "@/components/layouts/Audio.vue";

const { proxy } = getCurrentInstance();
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";
@import "@/assets/css/global.scss";

.el-container {
  min-height: calc(100% - 60px);
}
.el-header {
  padding: 0;
}
.el-main {
  padding-left: 0;
  padding-right: 0;
}
</style>
