<template>
  <div class="page-nav-container">
    <ul class="nav">
      <li 
        v-for="(item, index) in styleList" 
        :key="index" 
        :class="{ active: item.name == activeName }" 
        @click="handleChangeView(item)"
      >
        <span class="nav-text">{{ item.name }}</span>
        <div class="active-indicator"></div>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance } from "vue";

export default defineComponent({
  props: {
    styleList: Array,
    activeName: String,
  },
  emits: ["click"],
  setup() {
    const { proxy } = getCurrentInstance();

    function handleChangeView(val) {
      proxy.$emit("click", val);
    }
    return {
      handleChangeView,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.page-nav-container {
  overflow-x: auto;
  scrollbar-width: none; /* Firefox */
  -ms-overflow-style: none; /* IE and Edge */
  
  &::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera */
  }
}

.nav {
  width: 100%;
  display: flex;
  flex-wrap: wrap;
  padding: 0;
  margin: 0;
  
  li {
    position: relative;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    margin: 0.5rem 1rem;
    padding: 0.5rem 0.75rem;
    line-height: 1.5rem;
    font-size: 1rem;
    color: rgba(0, 0, 0, 0.65);
    border-radius: 6px;
    cursor: pointer;
    transition: all 0.3s ease;
    
    .nav-text {
      position: relative;
      z-index: 2;
    }
    
    .active-indicator {
      position: absolute;
      bottom: 0;
      left: 50%;
      width: 0;
      height: 2px;
      background-color: $color-blue-active;
      transform: translateX(-50%);
      transition: width 0.3s ease;
    }
    
    &:hover {
      color: $color-blue-active;
      background-color: rgba(0, 0, 0, 0.03);
      
      .active-indicator {
        width: 20px;
      }
    }
    
    &.active {
      color: $color-blue-active;
      font-weight: 600;
      background-color: rgba($color-blue-active, 0.05);
      
      .active-indicator {
        width: 70%;
      }
    }
  }
}

@media screen and (max-width: $sm) {
  .nav {
    li {
      margin: 0.3rem 0.4rem;
      padding: 0.4rem 0.6rem;
      font-size: 0.9rem;
    }
  }
}
</style>
