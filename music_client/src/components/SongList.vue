<template>
  <div class="content">
    <el-table v-loading="loading" highlight-current-row :data="dataList" @row-click="handleClick" :row-class-name="(row) => row.id === currentSongId ? 'current-row' : ''" @sort-change="handleSortChange">
      <el-table-column prop="name" label="歌曲" sortable="custom" />
      <el-table-column prop="singer.name" label="歌手" sortable="custom" />
      <el-table-column prop="introduction" label="专辑" />
      <el-table-column label="编辑" width="80" align="center">
        <template #default="scope">
          <el-dropdown>
            <el-icon @click="handleEdit(scope.row)"><MoreFilled /></el-icon>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item
                  :icon="Download"
                  @click="downloadMusic({
                    songUrl: scope.row.url
                  })"
                >下载</el-dropdown-item>
                <el-dropdown-item :icon="Delete" v-if="show" @click="deleteCollection({ id: scope.row.id })">删除</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, toRefs, computed, reactive, ref, watch } from "vue";
import { useStore } from "vuex";
import { MoreFilled, Delete, Download } from "@element-plus/icons-vue";
import { PropType } from "vue";

import mixin from "@/mixins/mixin";
import { HttpManager } from "@/api";
import { Icon } from "@/enums";

interface ResponseBody {
  code: number;
  success: boolean;
  message: string;
  type: string;
  data: any[];
}

interface Singer {
  id?: number;
  name: string;
}

interface Song {
  id: number;
  name: string;
  url?: string;
  pic?: string;
  lyric?: string;
  introduction?: string;
  singer?: Singer;
  index?: number;
}

export default defineComponent({
  components: {
    MoreFilled,
  },
  props: {
    songList: {
      type: Array as PropType<Song[]>,
      required: true
    },
    show: {
      type: Boolean,
      default: false
    }
  },
  emits: ["changeData"],
  setup(props) {
    const { playMusic, checkStatus, downloadMusic } = mixin();
    const { proxy } = getCurrentInstance();
    const store = useStore();

    const iconList = reactive({
      dislike: Icon.Dislike,
      like: Icon.Like,
    });

    const songUrl = computed(() => store.getters.songUrl);
    const singerName = computed(() => store.getters.singerName);
    const currentSongId = computed(() => store.getters.songId);
    const dataList = ref<Song[]>([]);
    const loading = ref(false);
    const currentSort = ref({ prop: '', order: '' });

    // 处理排序变化
    function handleSortChange(sort: { prop: string; order: string }) {
      currentSort.value = sort;
      if (!sort.prop) {
        // 如果没有排序字段，恢复原始顺序
        updateDataList();
        return;
      }

      const sortedList = [...dataList.value];
      sortedList.sort((a, b) => {
        let valueA, valueB;
        
        // 根据排序字段获取对应的值
        if (sort.prop === 'singer.name') {
          valueA = a.singer?.name || '';
          valueB = b.singer?.name || '';
        } else {
          valueA = a[sort.prop] || '';
          valueB = b[sort.prop] || '';
        }

        // 转换为小写进行比较
        valueA = valueA.toLowerCase();
        valueB = valueB.toLowerCase();

        if (sort.order === 'ascending') {
          return valueA.localeCompare(valueB);
        } else {
          return valueB.localeCompare(valueA);
        }
      });

      dataList.value = sortedList;
    }

    // 获取歌手信息并更新列表
    async function updateDataList() {
      if (!props.songList?.length) {
        dataList.value = [];
        return;
      }
      
      loading.value = true;
      try {
        const list: Song[] = [];
        for (const item of props.songList) {
          if (!item?.id) {
            console.warn('歌曲数据缺少 ID:', item);
            continue;
          }
          
          let songWithSinger = { ...item, index: list.length };
          
          // 如果歌曲没有歌手信息，尝试获取
          if (!item.singer?.name) {
            try {
              // 先尝试通过歌曲ID获取歌手信息
              const singerResult = await HttpManager.getSingerOfSongId(item.id) as ResponseBody;
              if (singerResult?.success && singerResult?.data?.length > 0) {
                songWithSinger.singer = singerResult.data[0];
              } else {
                // 如果通过ID获取失败，尝试通过歌曲名获取
                const singerByNameResult = await HttpManager.getSingerOfSongName(item.name) as ResponseBody;
                if (singerByNameResult?.success && singerByNameResult?.data?.length > 0) {
                  songWithSinger.singer = singerByNameResult.data[0];
                } else {
                  songWithSinger.singer = { name: '未知歌手' };
                }
              }
            } catch (error) {
              console.error('获取歌手信息失败:', error);
              songWithSinger.singer = { name: '未知歌手' };
            }
          }
          
          list.push(songWithSinger);
        }
        
        // 应用当前的排序
        dataList.value = list;
        if (currentSort.value.prop) {
          handleSortChange(currentSort.value);
        }
      } catch (error) {
        console.error('更新歌曲列表失败:', error);
        dataList.value = [];
      } finally {
        loading.value = false;
      }
    }

    // 监听歌曲列表变化
    watch(() => props.songList, (newVal) => {
      if (Array.isArray(newVal)) {
        updateDataList();
      } else {
        dataList.value = [];
      }
    }, { immediate: true, deep: true });

    function handleClick(row) {
      playMusic({
        id: row.id,
        url: row.url,
        pic: row.pic,
        index: row.index,
        name: row.name,
        lyric: row.lyric,
        introduction: row.introduction,
        currentSongList: props.songList,
      });
    }

    function handleEdit(row) {
      console.log("row", row);
    }

    const userId = computed(() => store.getters.userId);

    async function deleteCollection({ id }) {
      if (!checkStatus()) return;

      const result = (await HttpManager.deleteCollection(userId.value, id)) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
      });

      if (result.success === false) proxy.$emit("changeData", result.success);
    }

    return {
      dataList,
      iconList,
      Delete,
      Download,
      songUrl,
      singerName,
      handleClick,
      handleEdit,
      downloadMusic,
      deleteCollection,
      loading,
      currentSongId,
      handleSortChange,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";
@import "@/assets/css/global.scss";

.content {
  background-color: $color-white;
  border-radius: $border-radius-songlist;
  padding: 10px;
}

.content:deep(.el-table__row.current-row) {
  color: $color-black;
  font-weight: bold;
}

.content:deep(.el-table__row) {
  cursor: pointer;
}

.icon {
  @include icon(1.2em, $color-black);
}
</style>
