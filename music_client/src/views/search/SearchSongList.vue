<template>
  <div class="search-songlist-container">
    <div v-if="playList.length > 0" class="results-container">
      <play-list :playList="playList" path="song-sheet-detail"></play-list>
    </div>
    <div v-else class="no-results">
      <el-empty description="暂无搜索结果">
        <template #description>
          <p class="empty-description">暂无相关歌单</p>
          <p class="empty-suggestion">请尝试其他关键词</p>
        </template>
      </el-empty>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, computed, watch, onMounted, getCurrentInstance } from "vue";
import { useStore } from "vuex";
import PlayList from "@/components/PlayList.vue";
import { HttpManager } from "@/api";

export default defineComponent({
  components: {
    PlayList,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();

    const playList = ref([]);
    const loading = ref(false);
    const searchWord = computed(() => store.getters.searchWord);
    
    watch(searchWord, (value) => {
      getSearchList(value);
    });

    async function getSearchList(value) {
      if (!value) return;
      
      loading.value = true;
      try {
        const result = (await HttpManager.getSongListOfLikeTitle(value)) as ResponseBody;
        if (!result.data.length) {
          (proxy as any).$message({
            message: "暂无该歌单内容",
            type: "warning",
          });
          playList.value = [];
        } else {
          playList.value = result.data;
        }
      } catch (error) {
        console.error("搜索歌单失败:", error);
        (proxy as any).$message({
          message: "搜索请求失败",
          type: "error",
        });
        playList.value = [];
      } finally {
        loading.value = false;
      }
    }

    onMounted(() => {
      const keywords = proxy.$route.query.keywords;
      if (keywords) {
        getSearchList(keywords);
      }
    });

    return {
      playList,
      loading,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.search-songlist-container {
  padding: 0;
  min-height: 300px;
  position: relative;
}

.results-container {
  animation: fade-in 0.3s ease;
}

.no-results {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 300px;
  
  .empty-description {
    font-size: 16px;
    color: rgba(0, 0, 0, 0.65);
    margin-bottom: 8px;
  }
  
  .empty-suggestion {
    font-size: 14px;
    color: rgba(0, 0, 0, 0.45);
  }
}

@keyframes fade-in {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
