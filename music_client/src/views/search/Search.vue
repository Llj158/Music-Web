<template>
  <div class="search-container">
    <div class="search-header">
      <h1 class="search-title">搜索结果</h1>
      <p class="search-keywords" v-if="$store.state.searchKeywords">关键词: "{{ $store.state.searchKeywords }}"</p>
    </div>
    
    <div class="nav-container">
      <page-nav :styleList="searchNavList" :activeName="activeName" @click="handleChangeView"></page-nav>
    </div>
    
    <div class="search-content">
      <component class="search-list" :is="currentView"></component>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from "vue";
import PageNav from "@/components/layouts/PageNav.vue";
import SearchSong from "./SearchSong.vue";
import SearchSongList from "./SearchSongList.vue";

export default defineComponent({
  components: {
    PageNav,
    SearchSong,
    SearchSongList,
  },
  data() {
    return {
      searchNavList: [
        {
          name: "歌曲",
          value: "SearchSong",
        },
        {
          name: "歌单",
          value: "SearchSongList",
        },
      ],
      activeName: "歌曲",
      currentView: "SearchSong",
    };
  },
  methods: {
    handleChangeView(item) {
      this.activeName = item.name;
      this.currentView = item.value;
    },
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";
@import "@/assets/css/global.scss";

.search-container {
  padding: 20px 40px;
  background-color: #fafafa;
  min-height: calc(100vh - #{$header-height} - #{$play-bar-height});
  margin-top: 0;
  max-width: auto;
  margin-left: auto;
  margin-right: auto;
}

.search-header {
  margin-bottom: 24px;
  
  .search-title {
    font-size: 28px;
    font-weight: 600;
    color: rgba(0, 0, 0, 0.85);
    margin-bottom: 8px;
  }
  
  .search-keywords {
    font-size: 16px;
    color: rgba(0, 0, 0, 0.65);
    margin: 0;
  }
}

.nav-container {
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  padding: 8px 16px;
  margin-bottom: 24px;
  border: 1px solid rgba(0, 0, 0, 0.03);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
  
  &:hover {
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    transform: translateY(-2px);
  }
}

.search-content {
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  padding: 24px;
  border: 1px solid rgba(0, 0, 0, 0.03);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
  min-height: 480px;
  
  &:hover {
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    transform: translateY(-2px);
  }
}

@media screen and (max-width: $sm) {
  .search-container {
    padding: 15px;
  }
  
  .search-header {
    .search-title {
      font-size: 24px;
    }
  }
  
  .nav-container,
  .search-content {
    padding: 16px;
  }
}
</style>
