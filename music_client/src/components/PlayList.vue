<template>
  <div class="play-list">
    <div class="play-title" v-if="title">{{ title }}</div>
    <ul class="play-body">
      <li class="card-frame" v-for="(item, index) in playList" :key="index">
        <div class="card" @click="goAblum(item)">
          <div class="card-image-container">
            <el-image class="card-img" fit="cover" :src="attachImageUrl(item.pic)" />
            <div class="mask" @click.stop="goAblum(item)">
              <mus-icon class="mask-icon" :icon="BOFANG"></mus-icon>
            </div>
          </div>
          <div class="card-info">
            <p class="card-name">{{ item.name || item.title }}</p>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, toRefs } from "vue";
import { PropType } from "vue";

import MusIcon from "@/components/layouts/Icon.vue";
import mixin from "@/mixins/mixin";
import { Icon } from "@/enums";
import { HttpManager } from "@/api";

export default defineComponent({
  components: {
    MusIcon,
  },
  props: {
    title: String,
    playList: {
      type: Array as PropType<Array<{ id: number; pic: string; name?: string; title?: string }>>,
      default: () => []
    },
    path: String,
  },
  setup(props) {
    const { proxy } = getCurrentInstance();
    const { routerManager } = mixin();

    const { path } = toRefs(props);

    function goAblum(item) {
      proxy.$store.commit("setSongDetails", item);
      routerManager(path.value, { path: `/${path.value}/${item.id}` });
    }

    return {
      BOFANG: Icon.BOFANG,
      goAblum,
      attachImageUrl: HttpManager.attachImageUrl,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";
@import "@/assets/css/global.scss";

.play-list {
  padding: 0 1rem;

  .play-title {
    height: 60px;
    line-height: 60px;
    font-size: 24px;
    font-weight: 600;
    text-align: center;
    color: rgba(0, 0, 0, 0.85);
    position: relative;
    margin-bottom: 20px;
    
    &:after {
      content: '';
      position: absolute;
      bottom: 10px;
      left: 50%;
      transform: translateX(-50%);
      width: 40px;
      height: 3px;
      background-color: $color-blue-active;
      border-radius: 3px;
      transition: width 0.3s ease;
    }
  }

  .play-body {
    @include layout(flex-start, stretch, row, wrap);
  }
}

.card-frame {
  padding: 10px;
  transition: transform 0.3s ease;
  
  &:hover {
    transform: translateY(-5px);
  }
  
  .card {
    cursor: pointer;
    border-radius: 10px;
    background-color: #fff;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
    overflow: hidden;
    transition: all 0.3s ease;
    
    &:hover {
      box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
      
      .card-image-container {
        .card-img {
          transform: scale(1.05);
        }
        
        .mask {
          opacity: 1;
        }
      }
      
      .card-info {
        .card-name {
          color: $color-blue-active;
        }
      }
    }
    
    .card-image-container {
      position: relative;
      width: 100%;
      height: 0;
      padding-bottom: 100%;
      overflow: hidden;
      
      .card-img {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        transition: all 0.4s ease;
        object-fit: cover;
      }
    }
    
    .card-info {
      padding: 12px;
      
      .card-name {
        margin: 0;
        font-size: 14px;
        color: rgba(0, 0, 0, 0.85);
        overflow: hidden;
        text-overflow: ellipsis;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        line-height: 1.4;
        height: 2.8em;
        transition: color 0.3s ease;
      }
    }
  }
}

.mask {
  position: absolute;
  top: 0;
  width: 100%;
  height: 100%;
  overflow: hidden;
  background: linear-gradient(to top, rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.2));
  @include layout(center, center);
  transition: all 0.3s ease-in-out;
  opacity: 0;

  .mask-icon {
    @include icon(2.5em, rgba(255, 255, 255, 1));
    filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.3));
    transform: scale(0.8);
    transition: all 0.3s ease;
    
    &:hover {
      transform: scale(1);
    }
  }
}

@media screen and (min-width: $sm) {
  .card-frame {
    width: 18%;
    margin: 0.5rem 1%;
  }
}

@media screen and (max-width: $sm) {
  .card-frame {
    width: 46%;
    margin: 0.5rem 2%;
  }
  
  .play-list {
    padding: 0 0.5rem;
    
    .play-title {
      font-size: 20px;
      height: 50px;
      line-height: 50px;
    }
  }
}
</style>
