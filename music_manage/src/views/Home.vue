s2<template>
  <mus-header></mus-header>
  <mus-aside></mus-aside>
  <div class="fluent-content" :class="{ 'fluent-content-collapse': collapse }">
    <router-view></router-view>
  </div>
  <mus-audio></mus-audio>
</template>

<script lang="ts" setup>
import { ref } from "vue";
import MusHeader from "@/components/layouts/MusHeader.vue";
import MusAudio from "@/components/layouts/MusAudio.vue";
import MusAside from "@/components/layouts/MusAside.vue";
import emitter from "@/utils/emitter";

const collapse = ref(false);
emitter.on("collapse", (msg) => {
  collapse.value = msg as boolean;
});
</script>

<style scoped>
.fluent-content {
  position: absolute;
  left: 150px;
  right: 0;
  top: 60px;
  bottom: 0;
  overflow-y: scroll;
  transition: all 0.3s ease-in-out;
  padding: 20px;
  background-color: var(--fluent-background-secondary);
}

.fluent-content::-webkit-scrollbar {
  width: 8px;
  height: 8px;
}
  
.fluent-content::-webkit-scrollbar-thumb {
  border-radius: 4px;
  background-color: rgba(144, 147, 153, 0.3);
}

.fluent-content::-webkit-scrollbar-track {
  background-color: transparent;
}

.fluent-content-collapse {
  left: 65px;
}
</style>
