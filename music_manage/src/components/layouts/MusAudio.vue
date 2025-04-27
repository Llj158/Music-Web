<template>
  <audio controls preload="auto" v-if="url" ref="audioRef" :src="attachImageUrl(url)" @canplay="startPlay" @ended="ended"></audio>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, computed, watch, ref, onMounted } from "vue";
import { useStore } from "vuex";
import { HttpManager } from "@/api";

export default defineComponent({
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();
    const audioRef = ref<HTMLAudioElement | null>(null);

    const url = computed(() => store.getters.url); // 音乐链接
    const isPlay = computed(() => store.getters.isPlay); // 播放状态

    // 监听播放还是暂停
    watch(isPlay, (newValue) => {
      if (audioRef.value) {
        if (newValue) {
          audioRef.value.play();
        } else {
          audioRef.value.pause();
        }
      }
    });

    // 获取歌曲链接后准备播放
    function startPlay() {
      if (audioRef.value) {
        audioRef.value.play();
      }
    }

    // 音乐播放结束时触发
    function ended() {
      proxy.$store.commit("setIsPlay", false);
    }

    return {
      url,
      audioRef,
      startPlay,
      ended,
      attachImageUrl: HttpManager.attachImageUrl,
    };
  },
});
</script>

<style>
audio {
  display: none;
}
</style>
