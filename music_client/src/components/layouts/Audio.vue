<template>
  <audio 
    :src="actualSongUrl" 
    controls="controls" 
    :ref="player" 
    preload="metadata" 
    @canplay="canplay" 
    @timeupdate="timeupdate" 
    @ended="ended" 
    @error="handleError">
    <!--（1）属性：controls，preload（2）事件：canplay，timeupdate，ended（3）方法：play()，pause() -->
    <!--controls：向用户显示音频控件（播放/暂停/进度条/音量）-->
    <!--preload：属性规定是否在页面加载后载入音频-->
    <!--canplay：当音频/视频处于加载过程中时，会发生的事件-->
    <!--timeupdate：当目前的播放位置已更改时-->
    <!--ended：当目前的播放列表已结束时-->
  </audio>
</template>

<script lang="ts">
import { defineComponent, ref, getCurrentInstance, computed, watch, onMounted } from "vue";
import { useStore } from "vuex";
import { HttpManager } from "@/api";

export default defineComponent({
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();
    const divRef = ref<HTMLAudioElement>();
    const player = (el) => {
      divRef.value = el;
    };

    const muted = ref(false);
    const audioReady = ref(false);
    
    // 原始歌曲URL
    const songUrl = computed(() => store.getters.songUrl);
    
    // 实际使用的URL - 只有在URL有效时才设置
    const actualSongUrl = computed(() => {
      // 如果没有URL或URL为空字符串，返回空字符串(不触发加载)
      if (!songUrl.value || songUrl.value.trim() === '') {
        return '';
      }
      return HttpManager.attachImageUrl(songUrl.value);
    });
    
    const isPlay = computed(() => store.getters.isPlay);
    const volume = computed(() => store.getters.volume);
    const changeTime = computed(() => store.getters.changeTime);
    const autoNext = computed(() => store.getters.autoNext);

    // 页面加载时初始化音频
    onMounted(() => {
      // 设置初始音量
      if (divRef.value) {
        // 确保音量不为零
        divRef.value.volume = volume.value > 0 ? volume.value : 0.5;
        divRef.value.muted = false;
        console.log("音频初始化完成，音量:", divRef.value.volume, "静音状态:", divRef.value.muted);
      }
    });

    // 监听播放还是暂停
    watch(isPlay, (newValue) => {
      if (!audioReady.value || !divRef.value) return;
      
      if (newValue) {
        try {
          // 确保不是静音状态
          if (divRef.value.muted) {
            divRef.value.muted = false;
          }
          
          // 确保音量不为零
          if (divRef.value.volume === 0) {
            divRef.value.volume = 0.5;
            proxy.$store.commit("setVolume", 0.5);
          }
          
          console.log("播放前检查 - 音量:", divRef.value.volume, "静音状态:", divRef.value.muted);
          const playPromise = divRef.value.play();
          if (playPromise !== undefined) {
            playPromise.catch(error => {
              console.error('播放失败:', error);
              proxy.$store.commit("setIsPlay", false);
            });
          }
        } catch (e) {
          console.error('播放操作失败:', e);
          proxy.$store.commit("setIsPlay", false);
        }
      } else {
        try {
          divRef.value.pause();
        } catch (e) {
          console.error('暂停操作失败:', e);
        }
      }
    });

    // 监听URL变化
    watch(songUrl, (newUrl) => {
      // 重置准备状态
      audioReady.value = false;
      console.log("URL变更为:", newUrl);
      
      // 如果URL无效，不尝试播放
      if (!newUrl || newUrl.trim() === '') {
        if (isPlay.value) {
          proxy.$store.commit("setIsPlay", false);
        }
      }
    });

    // 跳到指定时刻播放
    watch(changeTime, (newTime) => {
      if (divRef.value && !isNaN(newTime)) {
        divRef.value.currentTime = newTime;
      }
    });

    // 监听音量变化
    watch(volume, (newVolume) => {
      if (divRef.value && !isNaN(newVolume)) {
        console.log("音量变更为:", newVolume);
        
        // 音量为0时设置为静音状态
        if (newVolume === 0) {
          divRef.value.muted = true;
          console.log("音量为0，设置为静音");
        } else {
          // 音量不为0时取消静音状态
          divRef.value.muted = false;
          divRef.value.volume = newVolume;
        }
      }
    });

    // 音频处理错误
    function handleError(e) {
      // 只有在有URL的情况下才记录错误
      if (songUrl.value && songUrl.value.trim() !== '') {
        console.error('音频加载错误:', e);
        audioReady.value = false;
        proxy.$store.commit("setIsPlay", false);
        
        // 向用户显示错误信息，仅在真正需要播放音频时
        if (isPlay.value) {
          (proxy as any).$message({
            message: "音频加载失败，请尝试其他歌曲",
            type: "error",
          });
        }
      }
    }

    // 获取歌曲链接后准备播放
    function canplay() {
      if (!divRef.value || !songUrl.value) return;
      
      console.log('音频已准备好播放');
      audioReady.value = true;
      
      // 记录音乐时长
      proxy.$store.commit("setDuration", divRef.value.duration);
      
      // 确保不是静音状态
      divRef.value.muted = false;
      muted.value = false;
      
      // 确保音量不为零
      if (divRef.value.volume === 0) {
        divRef.value.volume = 0.5;
        proxy.$store.commit("setVolume", 0.5);
      }
      
      console.log('音频准备播放 - 音量:', divRef.value.volume, '静音状态:', divRef.value.muted);
      
      // 如果状态是播放，尝试播放
      if (isPlay.value) {
        try {
          const playPromise = divRef.value.play();
          if (playPromise !== undefined) {
            playPromise.then(() => {
              console.log('播放成功开始');
            }).catch(error => {
              console.error('自动播放失败:', error);
              // 不更改播放状态，等待用户交互
            });
          }
        } catch (e) {
          console.error('播放操作失败:', e);
        }
      }
    }

    // 音乐播放时记录音乐的播放位置
    function timeupdate() {
      if (divRef.value) {
        proxy.$store.commit("setCurTime", divRef.value.currentTime);
      }
    }

    // 音乐播放结束时触发
    function ended() {
      proxy.$store.commit("setIsPlay", false);
      proxy.$store.commit("setCurTime", 0);
      proxy.$store.commit("setAutoNext", !autoNext.value);
    }

    return {
      songUrl,
      actualSongUrl,
      player,
      canplay,
      timeupdate,
      ended,
      handleError,
      muted,
      attachImageUrl: HttpManager.attachImageUrl,
    };
  },
});
</script>

<style scoped>
audio {
  display: none;
}
</style>
