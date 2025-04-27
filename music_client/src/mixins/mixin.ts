import { getCurrentInstance, computed } from "vue";
import { useStore } from "vuex";
import { LocationQueryRaw } from "vue-router";
import { RouterName } from "@/enums";
import { HttpManager } from "@/api";
import axios from 'axios'

interface routerOptions {
  path?: string;
  query?: LocationQueryRaw;
}

interface ResponseBody {
  code: number;
  success: boolean;
  message: string;
  type: string;
  data: any[];
}

export default function () {
  const { proxy } = getCurrentInstance();

  const store = useStore();
  const token = computed(() => store.getters.token);

  function getUserSex(sex) {
    if (sex === 0) {
      return "女";
    } else if (sex === 1) {
      return "男";
    }
  }

  // 判断登录状态
  function checkStatus(status?: boolean) {
    if (!token.value) {
      if (status !== false)
        (proxy as any).$message({
          message: "请先登录",
          type: "warning",
        });
      return false;
    }
    return true;
  }

  // 播放
  async function playMusic({ id, url, pic, index, name, lyric, introduction, currentSongList }) {
    try {
      // 验证参数，确保ID存在
      if (!id) {
        console.error('无效的歌曲ID');
        return;
      }

      // 验证URL是否有效
      if (!url || url.trim() === '') {
        console.error('歌曲URL为空');
        (proxy as any).$message({
          message: "无法播放：歌曲地址无效",
          type: "error",
        });
        return;
      }

      // 获取歌手信息
      const songTitle = name || '未知歌曲';
      let singerName = '未知歌手';

      try {
        const singerResult = await HttpManager.getSingerOfSongId(id) as ResponseBody;
        if (singerResult.success && singerResult.data && singerResult.data.length > 0) {
          singerName = singerResult.data[0].name;
        }
      } catch (error) {
        console.error('获取歌手信息失败:', error);
      }

      // 确保数据完整性
      const safePlayData = {
        id,
        url,
        pic: pic || '/img/songPic/tubiao.jpg',
        index,
        songTitle,
        singerName,
        introduction,
        lyric: lyric || '',
        currentSongList: Array.isArray(currentSongList) ? currentSongList : [],
      };

      // 派发播放事件
      proxy.$store.dispatch("playMusic", safePlayData);

      // 延迟设置播放状态，确保音频元素已加载
      setTimeout(() => {
        // 设置为播放状态
        proxy.$store.commit("setIsPlay", true);
      }, 100);

    } catch (error) {
      console.error('播放音乐失败:', error);
      (proxy as any).$message({
        message: "播放失败，请尝试其他歌曲",
        type: "error",
      });
    }
  }

  function getFileName(path) {
    const parts = path.split('/');
    return parts[parts.length - 1];
  }

  // 下载
  async function downloadMusic({ songUrl }) {
    if (!songUrl) {
      (proxy as any).$message({
        message: "下载链接为空！",
        type: "error",
      });
      console.error("下载链接为空！");
      return;
    }
    const fileName = getFileName(songUrl);
    const downUrl = "/download/" + fileName
    // const result = (await HttpManager.downloadMusic(downUrl)) as ResponseBody;
    // console.log(result.data);

    // const eleLink = document.createElement("a");
    // eleLink.download = `${fileName}`;
    // eleLink.style.display = "none";
    // // 字符内容转变成 blob 地址
    // const blob = new Blob([result.data]);
    // console.log(blob)
    // eleLink.href = URL.createObjectURL(blob);
    // document.body.appendChild(eleLink); // 触发点击
    // eleLink.click();
    // document.body.removeChild(eleLink); // 移除

    const response = await axios.get(downUrl, {
      responseType: 'blob', // 指定响应类型为二进制数据
    });

    // 创建一个Blob URL来下载文件
    const blob = new Blob([response.data], { type: 'application/octet-stream' });
    const url = window.URL.createObjectURL(blob);

    // 创建一个隐藏的<a>标签来下载文件
    const link = document.createElement('a');
    link.href = url;
    link.download = fileName;
    document.body.appendChild(link);
    link.click();

    // 释放URL对象
    window.URL.revokeObjectURL(url);
    document.body.removeChild(link);

  }

  // 导航索引
  function changeIndex(value) {
    proxy.$store.commit("setActiveNavName", value);
  }
  // 路由管理
  function routerManager(routerName: string | number, options: routerOptions) {
    switch (routerName) {
      case RouterName.Search:
        proxy.$router.push({ path: options.path, query: options.query });
        break;
      case RouterName.Home:
      case RouterName.SongSheet:
      case RouterName.SongSheetDetail:
      case RouterName.Singer:
      case RouterName.SingerDetail:
      case RouterName.Personal:
      case RouterName.PersonalData:
      case RouterName.Setting:
      case RouterName.SignIn:
      case RouterName.SignUp:
      case RouterName.SignOut:
      case RouterName.Lyric:
      case RouterName.Error:
      default:
        proxy.$router.push({ path: options.path });
        break;
    }
  }

  function goBack(step = -1) {
    proxy.$router.go(step);
  }

  return {
    getUserSex,
    changeIndex,
    checkStatus,
    playMusic,
    routerManager,
    goBack,
    downloadMusic,
  };
}
