<template>
  <div class="singer-container">
    <div class="category-nav-container">
      <page-nav :styleList="singerStyle" :activeName="activeName" @click="handleChangeView"></page-nav>
    </div>
    
    <div class="content-section">
      <play-list :playList="data" path="singer-detail"></play-list>
      
      <div class="pagination-container">
        <el-pagination
          class="pagination"
          background
          layout="total, prev, pager, next"
          :current-page="currentPage"
          :page-size="pageSize"
          :total="allPlayList.length"
          @current-change="handleCurrentChange"
        >
        </el-pagination>
      </div>
    </div>
  </div>
</template>

<script lang="ts" setup>
import { ref, computed } from "vue";
import PageNav from "@/components/layouts/PageNav.vue";
import PlayList from "@/components/PlayList.vue";
import { singerStyle } from "@/enums";
import { HttpManager } from "@/api";

// data
const activeName = ref("全部歌手");
const pageSize = ref(8); // 页数
const currentPage = ref(1); // 当前页
const allPlayList = ref([]);
// computed
const data = computed(() => {
  return allPlayList.value.slice((currentPage.value - 1) * pageSize.value, currentPage.value * pageSize.value);
});

// 获取所有歌手
async function getAllSinger() {
  const result = (await HttpManager.getAllSinger()) as ResponseBody;
  currentPage.value = 1;
  allPlayList.value = result.data;
}

getAllSinger();

// 获取当前页
function handleCurrentChange(val) {
  currentPage.value = val;
}

function handleChangeView(item) {
  activeName.value = item.name;
  allPlayList.value = [];
  if (item.name === "全部歌手") {
    getAllSinger();
  } else {
    getSingerSex(item.type);
  }
}

// 通过性别对歌手分类
async function getSingerSex(sex) {
  const result = (await HttpManager.getSingerOfSex(sex)) as ResponseBody;
  currentPage.value = 1;
  allPlayList.value = result.data;
}
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.singer-container {
  padding: 20px 40px;
  background-color: #fafafa;
  min-height: calc(100vh - #{$header-height} - #{$play-bar-height});
}

.category-nav-container {
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  padding: 16px 24px;
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

.content-section {
  background-color: rgba(255, 255, 255, 0.8);
  border-radius: 12px;
  padding: 24px;
  border: 1px solid rgba(0, 0, 0, 0.03);
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
  backdrop-filter: blur(10px);
  transition: all 0.3s ease;
  
  &:hover {
    box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
    transform: translateY(-2px);
  }
}

.pagination-container {
  margin-top: 30px;
  display: flex;
  justify-content: center;
  
  .pagination {
    :deep(.el-pagination__total) {
      font-size: 14px;
      color: rgba(0, 0, 0, 0.65);
    }
    
    :deep(.btn-prev),
    :deep(.btn-next) {
      background-color: transparent;
      border: 1px solid rgba(0, 0, 0, 0.08);
      color: rgba(0, 0, 0, 0.65);
      transition: all 0.3s ease;
      
      &:hover {
        background-color: rgba(0, 0, 0, 0.03);
        color: $color-blue-active;
      }
      
      &:disabled {
        color: rgba(0, 0, 0, 0.25);
      }
    }
    
    :deep(.el-pager li) {
      background-color: transparent;
      border: 1px solid rgba(0, 0, 0, 0.08);
      color: rgba(0, 0, 0, 0.65);
      font-weight: 400;
      margin: 0 4px;
      transition: all 0.3s ease;
      
      &:hover {
        color: $color-blue-active;
      }
      
      &.active {
        background-color: $color-blue-active;
        color: #fff;
        font-weight: 600;
        border-color: $color-blue-active;
      }
    }
  }
}

@media screen and (max-width: $sm) {
  .singer-container {
    padding: 15px;
  }
  
  .category-nav-container,
  .content-section {
    padding: 16px;
  }
  
  .pagination-container {
    margin-top: 20px;
  }
}
</style>
