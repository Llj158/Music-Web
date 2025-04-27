<template>
  <div class="comment">
    <h2 class="comment-title">
      <span class="comment-desc">共 {{ commentList.length }} 条评论</span>
    </h2>
    <el-input class="comment-input" type="textarea" placeholder="期待您的精彩评论..." :rows="2" v-model="textarea" />
    <el-button class="sub-btn" type="primary" @click="submitComment()">发表评论</el-button>
  </div>
  <ul class="popular">
    <li v-for="(item, index) in commentList" :key="index">
      <el-image class="popular-img" fit="contain" :src="attachImageUrl(item.avator)" />
      <div class="popular-msg">
        <ul>
          <li class="name">{{ item.username }}</li>
          <li class="time">{{ formatDate(item.createTime) }}</li>
          <li class="content">{{ item.content }}</li>
        </ul>
      </div>
      <div class="comment-actions">
        <div ref="up" class="support-btn" @click="setSupport(item.id, item.up, userId)">
          <div :class="{ 'active-support': item.isSupport }">
            <mus-icon :icon="iconList.Support"></mus-icon> {{ item.up }}
          </div>
        </div>
        <div v-if="item.userId === userId" class="delete-btn" @click.stop="deleteComment(item.id, index)">
          <el-icon><delete /></el-icon>
        </div>
      </div>
    </li>
  </ul>
</template>

<script lang="ts" setup>

import { defineProps, getCurrentInstance, ref, toRefs, computed, watch, reactive, onMounted } from "vue";
import { useStore } from "vuex";
import { Delete } from "@element-plus/icons-vue";
import { ElMessageBox, ElMessage } from "element-plus";

import MusIcon from "@/components/layouts/Icon.vue";
import mixin from "@/mixins/mixin";
import { HttpManager } from "@/api";
import { Icon } from "@/enums";
import { formatDate } from "@/utils";

const { proxy } = getCurrentInstance();
const store = useStore();
const { checkStatus } = mixin();

const props = defineProps({
  playId: Number || String, // 歌曲ID 或 歌单ID
  type: Number, // 歌单 1 / 歌曲 0
});

const { playId, type } = toRefs(props);
const textarea = ref(""); // 存放输入内容
const commentList = ref([]); // 存放评论内容
const iconList = reactive({
  Support: Icon.Support,
});

const userId = computed(() => store.getters.userId);

onMounted(() => {
  getComment(playId.value);
});

// 监听playId的变化
watch(playId, (newVal) => {
  if (newVal) {
    getComment(newVal);
  }
});

// 获取所有评论
async function getComment(id) {
  try {
    const result = (await HttpManager.getAllComment(type.value, id)) as ResponseBody;
    commentList.value = result.data;
    for (let index = 0; index < commentList.value.length; index++) {
      // 获取评论用户的昵称和头像
      const resultUser = (await HttpManager.getUserOfId(commentList.value[index].userId)) as ResponseBody;
      commentList.value[index].avator = resultUser.data[0].avator;
      commentList.value[index].username = resultUser.data[0].username;
      
      // 检查当前用户是否已点赞该评论
      if (userId.value) {
        const supportResult = (await HttpManager.testAlreadySupport({ 
          commentId: commentList.value[index].id, 
          userId: userId.value 
        })) as ResponseBody;
        commentList.value[index].isSupport = supportResult.data;
      }
    }
  } catch (error) {
    console.error('[获取所有评论失败]===>', error);
  }
}

// 提交评论
async function submitComment() {
  if (!checkStatus()) return;

  // 0 代表歌曲， 1 代表歌单
  let songListId = null;  // 默认为null
  let songId = null;     // 默认为null
  let nowType = type.value;

  if (type.value === 1) {
    songListId = `${playId.value}`;
  } else if (type.value === 0) {
    songId = `${playId.value}`;
  }

  const content = textarea.value;
  if (!content.trim()) {
    ElMessage({
      message: "评论内容不能为空",
      type: "warning"
    });
    return;
  }

  const result = (await HttpManager.setComment({ 
    userId: userId.value, 
    content, 
    songId, 
    songListId, 
    nowType 
  })) as ResponseBody;

  ElMessage[result.type](result.message);

  if (result.success) {
    textarea.value = "";
    await getComment(playId.value);
  }
}

// 删除评论
async function deleteComment(id, index) {
  try {
    await ElMessageBox.confirm('确定要删除这条评论吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    });
    
    const result = (await HttpManager.deleteComment(id)) as ResponseBody;
    if (result.success) {
      commentList.value.splice(index, 1);
      ElMessage({
        message: '删除成功',
        type: 'success'
      });
    } else {
      ElMessage({
        message: result.message || '删除失败',
        type: 'error'
      });
    }
  } catch (error) {
    if (error !== 'cancel') {
      console.error('删除评论失败:', error);
      ElMessage({
        message: '删除失败',
        type: 'error'
      });
    }
  }
}

// 点赞
async function setSupport(id, up, userId) {
  if (!checkStatus()) return;

  let result = null;
  let operatorR = null;
  const commentId = id;

  const r = (await HttpManager.testAlreadySupport({ commentId, userId })) as ResponseBody;

  if (r.data) {
    up = up - 1;
    operatorR = (await HttpManager.deleteUserSupport({ commentId, userId })) as ResponseBody;
    result = (await HttpManager.setSupport({ id, up })) as ResponseBody;
  } else {
    up = up + 1;
    operatorR = (await HttpManager.insertUserSupport({ commentId, userId })) as ResponseBody;
    result = (await HttpManager.setSupport({ id, up })) as ResponseBody;
  }
  if (result.success && operatorR.success) {
    (proxy as any).$message({
      message: r.data ? "取消点赞成功" : "点赞成功",
      type: "success"
    });
    await getComment(playId.value);
  } else {
    (proxy as any).$message({
      message: "操作失败",
      type: "error"
    });
  }
}

const attachImageUrl = HttpManager.attachImageUrl;
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";
@import "@/assets/css/global.scss";

/*评论*/
.comment {
  position: relative;
  margin-bottom: 60px;

  .comment-title {
    height: 50px;
    line-height: 50px;

    .comment-desc {
      font-size: 14px;
      font-weight: 400;
      color: $color-grey;
      margin-left: 10px;
    }
  }

  .comment-input {
    display: flex;
    margin-bottom: 20px;
  }

  .sub-btn {
    position: absolute;
    right: 0;
  }
}

/*热门评论*/
.popular {
  width: 100%;
  > li {
    border-bottom: solid 1px rgba(0, 0, 0, 0.1);
    padding: 15px 0;
    display: flex;
    position: relative;
    
    .popular-img {
      width: 50px;
    }

    .popular-msg {
      padding: 0 20px;
      flex: 1;
      margin-right: 120px;  // 为右侧按钮留出空间
      li {
        width: 100%;
      }
      .time {
        font-size: 0.6rem;
        color: rgba(0, 0, 0, 0.5);
      }
      .name {
        color: rgba(0, 0, 0, 0.5);
      }
      .content {
        font-size: 1rem;
      }
    }

    .comment-actions {
      position: absolute;
      right: 0;
      top: 50%;
      transform: translateY(-50%);
      display: flex;
      align-items: center;
      gap: 30px;  // 按钮之间的间距

      .support-btn {
        display: flex;
        align-items: center;
        cursor: pointer;
        padding: 5px 10px;
        border-radius: 4px;
        transition: all 0.3s;

        &:hover {
          background-color: rgba(64, 158, 255, 0.1);
        }

        .active-support {
          color: #409EFF;
          
          :deep(.icon) {
            color: #409EFF;
          }
        }
      }

      .delete-btn {
        cursor: pointer;
        padding: 5px 10px;
        border-radius: 4px;
        color: #f56c6c;
        transition: all 0.3s;

        &:hover {
          background-color: rgba(245, 108, 108, 0.1);
        }
      }
    }
  }
}

.icon {
  @include icon(1em);
}
</style>
