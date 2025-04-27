<template>
  <el-row :gutter="20">
    <el-col :span="6">
      <el-card class="fluent-card fluent-dashboard-card" shadow="hover">
        <div class="fluent-card-content">
          <div class="fluent-card-icon">
            <el-icon><user /></el-icon>
          </div>
          <div class="fluent-card-info">
            <div class="fluent-card-num">{{ userCount }}</div>
            <div class="fluent-card-title">用户总数</div>
          </div>
        </div>
      </el-card>
    </el-col>
    <el-col :span="6">
      <el-card class="fluent-card fluent-dashboard-card" shadow="hover">
        <div class="fluent-card-content">
          <div class="fluent-card-icon fluent-icon-blue">
            <el-icon><headset /></el-icon>
          </div>
          <div class="fluent-card-info">
            <div class="fluent-card-num">{{ songCount }}</div>
            <div class="fluent-card-title">歌曲总数</div>
          </div>
        </div>
      </el-card>
    </el-col>
    <el-col :span="6">
      <el-card class="fluent-card fluent-dashboard-card" shadow="hover">
        <div class="fluent-card-content">
          <div class="fluent-card-icon fluent-icon-purple">
            <el-icon><mic /></el-icon>
          </div>
          <div class="fluent-card-info">
            <div class="fluent-card-num">{{ singerCount }}</div>
            <div class="fluent-card-title">歌手数量</div>
          </div>
        </div>
      </el-card>
    </el-col>
    <el-col :span="6">
      <el-card class="fluent-card fluent-dashboard-card" shadow="hover">
        <div class="fluent-card-content">
          <div class="fluent-card-icon fluent-icon-green">
            <el-icon><document /></el-icon>
          </div>
          <div class="fluent-card-info">
            <div class="fluent-card-num">{{ songListCount }}</div>
            <div class="fluent-card-title">歌单数量</div>
          </div>
        </div>
      </el-card>
    </el-col>
  </el-row>
  <el-row :gutter="20">
    <el-col :span="12">
      <h3 class="fluent-section-title">用户性别比例</h3>
      <el-card class="fluent-card fluent-chart-card" shadow="hover">
        <div id="userSex" class="chart-container"></div>
      </el-card>
    </el-col>
    <el-col :span="12">
      <h3 class="fluent-section-title">歌手性别比例</h3>
      <el-card class="fluent-card fluent-chart-card" shadow="hover">
        <div id="singerSex" class="chart-container"></div>
      </el-card>
    </el-col>
  </el-row>
  <el-row :gutter="20">
    <el-col :span="24">
      <h3 class="fluent-section-title">歌单评分排名</h3>
      <el-card class="fluent-card fluent-chart-card" shadow="hover">
        <div class="chart-header">
          <el-button type="primary" size="small" @click="toggleExpand">
            {{ isExpanded ? '收起' : '展开全部' }}
          </el-button>
        </div>
        <div id="songListRank" class="chart-container"></div>
      </el-card>
    </el-col>
  </el-row>
</template>
<script lang="ts" setup>
// import { ref, reactive, getCurrentInstance } from "vue";
import { ref, reactive, onMounted } from "vue";
import * as echarts from "echarts";
import { Mic, Document, User, Headset } from "@element-plus/icons-vue";
import { HttpManager } from "@/api/index";

// const { proxy } = getCurrentInstance();
const userCount = ref(0);
const songCount = ref(0);
const singerCount = ref(0);
const songListCount = ref(0);
const isExpanded = ref(false);
const allSongListData = ref([]);
const userSex = reactive({
  tooltip: {
    trigger: 'item',
    formatter: '{a} <br/>{b} : {c} ({d}%)'
  },
  legend: {
    orient: 'vertical',
    left: 'right',
    textStyle: {
      fontSize: 14
    }
  },
  series: [
    {
      name: '用户性别',
      type: "pie",
      radius: ['40%', '70%'],
      center: ['40%', '50%'],
      avoidLabelOverlap: false,
      label: {
        show: true,
        formatter: '{b}: {c} ({d}%)',
        fontSize: 14
      },
      data: [
        {
          value: 0,
          name: "男",
        },
        {
          value: 0,
          name: "女",
        },
      ],
      emphasis: {
        itemStyle: {
          shadowBlur: 10,
          shadowOffsetX: 0,
          shadowColor: 'rgba(0, 0, 0, 0.2)'
        }
      }
    },
  ],
});
const songListRank = reactive({
  tooltip: {
    trigger: 'axis',
    axisPointer: {
      type: 'shadow'
    }
  },
  grid: {
    left: '3%',
    right: '8%',
    bottom: '3%',
    top: '5%',
    containLabel: true
  },
  xAxis: {
    type: 'value',
    name: '评分',
    max: 10,
    splitNumber: 5,
    axisLabel: {
      formatter: '{value} 分',
      fontSize: 14
    },
    nameTextStyle: {
      fontSize: 15,
      padding: [0, 0, 0, 10]
    }
  },
  yAxis: {
    type: 'category',
    data: [],
    name: '歌单',
    axisLabel: {
      width: 150,
      overflow: 'truncate',
      fontSize: 14
    },
    nameTextStyle: {
      fontSize: 15,
      padding: [0, 0, 10, 0]
    }
  },
  series: [
    {
      type: 'bar',
      data: [],
      label: {
        show: true,
        position: 'right',
        formatter: '{c} 分',
        fontSize: 14,
        fontWeight: 'bold'
      },
      itemStyle: {
        color: '#5470c6'
      },
      barWidth: '60%'
    }
  ]
});
const singerSex = reactive({
  tooltip: {
    trigger: 'item',
    formatter: '{a} <br/>{b} : {c} ({d}%)'
  },
  legend: {
    orient: 'vertical',
    left: 'right',
    textStyle: {
      fontSize: 14
    }
  },
  series: [
    {
      name: '歌手性别',
      type: "pie",
      radius: ['40%', '70%'],
      center: ['40%', '50%'],
      avoidLabelOverlap: false,
      label: {
        show: true,
        formatter: '{b}: {c} ({d}%)',
        fontSize: 14
      },
      data: [
        {
          value: 0,
          name: "男",
        },
        {
          value: 0,
          name: "女",
        },
        {
          value: 0,
          name: "组合",
        },
        {
          value: 0,
          name: "不明",
        },
      ],
      emphasis: {
        itemStyle: {
          shadowBlur: 10,
          shadowOffsetX: 0,
          shadowColor: 'rgba(0, 0, 0, 0.2)'
        }
      }
    },
  ],
});

function setSex(sex, arr) {
  let value = 0;
  let name;
  switch (sex) {
    case 0:
      name = "女";
      break;
    case 1:
      name = "男";
      break;
    case 2:
      name = "组合";
      break;
    default:
      name = "不明";
  }
  for (let item of arr) {
    if (sex === item.sex) {
      value++;
    }
  }
  return { value, name };
}
HttpManager.getAllUser().then((res) => {
  const result = res as ResponseBody;
  userCount.value = result.data.length;
  userSex.series[0].data = [
    setSex(0, result.data),
    setSex(1, result.data)
  ].filter(item => item.value > 0);

  const userSexChart = echarts.init(document.getElementById("userSex"));
  userSexChart.setOption(userSex);
  
  // 添加窗口大小变化的监听器
  window.addEventListener('resize', () => {
    userSexChart.resize();
  });
});

HttpManager.getAllSong().then((res) => {
  songCount.value = (res as ResponseBody).data.length;
});
HttpManager.getSongList().then((res) => {
  const result = res as ResponseBody;
  songListCount.value = result.data.length;
});

HttpManager.getAllSinger().then((res) => {
  const result = res as ResponseBody;
  singerCount.value = result.data.length;
  singerSex.series[0].data = [
    setSex(0, result.data),
    setSex(1, result.data),
    setSex(2, result.data),
    setSex(3, result.data)
  ].filter(item => item.value > 0);
  const singerSexChart = echarts.init(document.getElementById("singerSex"));
  singerSexChart.setOption(singerSex);
  
  // 添加窗口大小变化的监听器
  window.addEventListener('resize', () => {
    singerSexChart.resize();
  });
});

// 切换展开/收起状态
function toggleExpand() {
  isExpanded.value = !isExpanded.value;
  updateSongListChart();
}

// 更新歌单图表
function updateSongListChart() {
  const displayCount = isExpanded.value ? allSongListData.value.length : 8;
  const displayData = allSongListData.value.slice(0, displayCount);
  
  const titles = [...displayData.map(item => item.title)].reverse();
  const scores = [...displayData.map(item => item.score)].reverse();
  
  songListRank.yAxis.data = titles;
  songListRank.series[0].data = scores;
  
  // 重新调整图表高度以适应内容
  const chartContainer = document.getElementById("songListRank");
  if (chartContainer) {
    // 如果元素已经存在，重新初始化
    let chartHeight = Math.max(350, displayCount * 40); // 增加每行的高度
    chartContainer.style.height = `${chartHeight}px`;
    
    const songListRankChart = echarts.init(chartContainer);
    songListRankChart.setOption(songListRank);
    
    // 添加窗口大小变化的监听器
    window.addEventListener('resize', () => {
      songListRankChart.resize();
    });
  }
}

// 获取歌单评分排名
HttpManager.getSongListRankOrder().then((res) => {
  const result = res as ResponseBody;
  if (result.success && result.data) {
    // 处理数据，将分数保留一位小数
    allSongListData.value = result.data.map(item => ({
      ...item,
      score: parseFloat(parseFloat(item.score).toFixed(1))
    }));
    
    // 修改图表的格式化配置
    songListRank.series[0].label.formatter = (params) => {
      return params.value.toFixed(1) + ' 分';
    };
    
    // 初始只显示8个
    updateSongListChart();
  }
});
</script>

<style scoped>
.fluent-section-title {
  font-family: var(--fluent-font-family);
  font-size: var(--fluent-font-size-large);
  color: var(--fluent-text-primary);
  margin: 20px 0 15px 0;
  font-weight: var(--fluent-font-weight-semibold);
}

.chart-header {
  display: flex;
  justify-content: flex-end;
  margin-bottom: 10px;
}

.chart-container {
  height: 350px;
  width: 100%;
}

.chart-actions {
  position: absolute;
  top: 10px;
  right: 10px;
  z-index: 100;
}

.fluent-dashboard-card {
  margin-bottom: 20px;
  transition: var(--fluent-transition);
}

.fluent-dashboard-card:hover {
  transform: translateY(-5px);
}

.fluent-card-content {
  display: flex;
  align-items: center;
  padding: 20px;
}

.fluent-card-icon {
  width: 60px;
  height: 60px;
  border-radius: 50%;
  background-color: var(--fluent-primary);
  display: flex;
  justify-content: center;
  align-items: center;
  margin-right: 15px;
  color: white;
  font-size: 24px;
}

.fluent-icon-blue {
  background-color: #4285f4;
}

.fluent-icon-purple {
  background-color: #9c27b0;
}

.fluent-icon-green {
  background-color: #4caf50;
}

.fluent-card-info {
  flex: 1;
}

.fluent-card-num {
  font-size: var(--fluent-font-size-xxlarge);
  font-weight: var(--fluent-font-weight-bold);
  color: var(--fluent-text-primary);
  line-height: 1.2;
}

.fluent-card-title {
  font-size: var(--fluent-font-size-medium);
  color: var(--fluent-text-secondary);
  margin-top: 5px;
}

.fluent-chart-card {
  height: auto;
  margin-bottom: 20px;
  position: relative;
}

.cav-info {
  height: 280px;
}
</style>
