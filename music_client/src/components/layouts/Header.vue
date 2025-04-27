<template>
  <div class="header">
    <!--图标-->
    <div class="header-logo" @click="goPage('', '')">
      <mus-icon :icon="iconList.ERJI"></mus-icon>
      <span>{{ musicName }}</span>
    </div>
    <header-nav class="header-nav" :styleList="headerNavList" :activeName="activeNavName" @click="goPage"></header-nav>
    <!--搜索框-->
    <div class="header-search">
      <el-input placeholder="搜索" :prefix-icon="Search" v-model="keywords" @keyup.enter="goSearch()" />
    </div>
    <!--设置-->
    <header-nav v-if="!token" :styleList="signList" :activeName="activeNavName" @click="goPage"></header-nav>
    <el-dropdown class="user-wrap" v-if="token" trigger="click">
      <div class="avatar-container">
        <el-image class="user" fit="contain" :src="attachImageUrl(userPic)" />
      </div>
      <template #dropdown>
        <el-dropdown-menu>
          <el-dropdown-item v-for="(item, index) in menuList" :key="index" @click.stop="goMenuList(item.path)">{{ item.name }}</el-dropdown-item>
        </el-dropdown-menu>
      </template>
    </el-dropdown>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref, getCurrentInstance, computed, reactive } from "vue";
import { Search } from "@element-plus/icons-vue";
import { useStore } from "vuex";
import MusIcon from "./Icon.vue";
import HeaderNav from "./HeaderNav.vue";
import mixin from "@/mixins/mixin";
import { HEADERNAVLIST, SIGNLIST, MENULIST, Icon, MUSICNAME, RouterName, NavName } from "@/enums";
import { HttpManager } from "@/api";

export default defineComponent({
  components: {
    MusIcon,
    HeaderNav,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();
    const { changeIndex, routerManager } = mixin();

    const musicName = ref(MUSICNAME);
    const headerNavList = ref(HEADERNAVLIST); // 左侧导航栏
    const signList = ref(SIGNLIST); // 右侧导航栏
    const menuList = ref(MENULIST); // 用户下拉菜单项
    const iconList = reactive({
      ERJI: Icon.ERJI,
    });
    const keywords = ref("");
    const activeNavName = computed(() => store.getters.activeNavName);
    const userPic = computed(() => store.getters.userPic);
    const token = computed(() => store.getters.token);

    function goPage(path, name) {
      if (!path && !name) {
        changeIndex(NavName.Home);
        routerManager(RouterName.Home, { path: RouterName.Home });
      } else {
        changeIndex(name);
        routerManager(path, { path });
      }
    }

    function goMenuList(path) {
      if (path == RouterName.SignOut) {
        localStorage.removeItem('token');
        proxy.$store.commit("setToken", false);
        proxy.$store.commit("setUserId", "");
        proxy.$store.commit("setUsername", "");
        proxy.$store.commit("setUserPic", "");
        changeIndex(NavName.Home);
        routerManager(RouterName.Home, { path: RouterName.Home });
      } else {
        routerManager(path, { path });
      }
    }
    function goSearch() {
      if (keywords.value !== "") {
        proxy.$store.commit("setSearchWord", keywords.value);
        routerManager(RouterName.Search, { path: RouterName.Search, query: { keywords: keywords.value } });
      } else {
        (proxy as any).$message({
          message: "搜索内容不能为空",
          type: "error",
        });
      }
    }

    return {
      musicName,
      headerNavList,
      signList,
      menuList,
      iconList,
      keywords,
      activeNavName,
      userPic,
      token,
      Search,
      goPage,
      goMenuList,
      goSearch,
      attachImageUrl: HttpManager.attachImageUrl,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";
@import "@/assets/css/global.scss";

@media screen and (min-width: $sm) {
  .header-logo {
    margin: 0 1rem;
  }
}

@media screen and (max-width: $sm) {
  .header-logo {
    margin: 0 1rem;
    span {
      display: none;
    }
  }
  .header-search {
    display: none;
  }
}

.header {
  position: fixed;
  width: 100%;
  height: $header-height;
  line-height: $header-height;
  padding: $header-padding;
  margin: $header-margin;
  background-color: rgba(255, 255, 255, 0.85);
  backdrop-filter: blur(10px);
  box-shadow: 0 1px 10px rgba(0, 0, 0, 0.1);
  box-sizing: border-box;
  z-index: 100;
  display: flex;
  white-space: nowrap;
  flex-wrap: nowrap;
}

/* LOGO */
.header-logo {
  font-size: $font-size-logo;
  font-weight: bold;
  cursor: pointer;
  transition: transform 0.2s ease;
  display: flex;
  align-items: center;
  
  &:hover {
    transform: scale(1.02);
  }

  .icon {
    @include icon(1.9rem, $color-blue-active);
    vertical-align: middle;
    transition: transform 0.3s ease;
    
    &:hover {
      transform: rotate(15deg);
    }
  }
  
  span {
    margin-left: 1rem;
    color: rgba(0, 0, 0, 0.85);
  }
}

.header-nav {
  flex: 1;
  
  :deep(.header-nav) {
    .item {
      position: relative;
      transition: color 0.3s ease;
      
      &::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 50%;
        width: 0;
        height: 2px;
        background-color: $color-blue-active;
        transition: all 0.3s ease;
        transform: translateX(-50%);
      }
      
      &:hover {
        color: $color-blue-active;
        
        &::after {
          width: 100%;
        }
      }
      
      &.active {
        color: $color-blue-active;
        
        &::after {
          width: 100%;
        }
      }
    }
  }
}

/*搜索输入框*/
.header-search {
  margin: 0 20px;
  width: 100%;
  
  :deep(.el-input) {
    .el-input__wrapper {
      background-color: rgba(0, 0, 0, 0.03);
      border-radius: 20px;
      padding: 0 15px;
      transition: all 0.3s ease;
      box-shadow: none;
      
      &:hover {
        background-color: rgba(0, 0, 0, 0.05);
      }
      
      &.is-focus {
        background-color: #fff;
        box-shadow: 0 0 0 1px $color-blue-active inset;
      }
    }
    
    .el-input__inner {
      color: rgba(0, 0, 0, 0.85);
      
      &::placeholder {
        color: rgba(0, 0, 0, 0.45);
      }
    }
    
    .el-input__prefix {
      color: rgba(0, 0, 0, 0.45);
    }
  }
}

/*用户*/
.user-wrap {
  position: relative;
  display: flex;
  align-items: center;

  .user {
    width: $header-user-width;
    height: $header-user-width;
    border-radius: $header-user-radius;
    margin-right: $header-user-margin;
    cursor: pointer;
    overflow: hidden;
    object-fit: cover;
    transition: transform 0.3s ease;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
    
    &:hover {
      transform: scale(1.1);
    }
  }
}

:deep(.el-dropdown-menu) {
  border-radius: 8px;
  padding: 4px;
  background-color: rgba(255, 255, 255, 0.98);
  backdrop-filter: blur(10px);
  border: 1px solid rgba(0, 0, 0, 0.06);
  box-shadow: 0 3px 12px rgba(0, 0, 0, 0.1);
  
  .el-dropdown-menu__item {
    padding: 8px 16px;
    border-radius: 4px;
    transition: all 0.2s ease;
    
    &:hover {
      background-color: rgba(0, 0, 0, 0.03);
      color: $color-blue-active;
    }
  }
}
</style>
