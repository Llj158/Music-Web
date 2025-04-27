<template>
  <div class="fluent-login-container" :class="{ 'blur-background': isCardHovered }">
    <div class="fluent-login-card" 
         @mouseenter="isCardHovered = true" 
         @mouseleave="isCardHovered = false">
      <div class="fluent-login-title">{{ nusicName }}</div>
      <div class="fluent-login-subtitle">管理员登录</div>
      <el-form :model="ruleForm" :rules="rules" class="fluent-form">
        <el-form-item prop="username">
          <el-input 
            v-model="ruleForm.username" 
            placeholder="用户名" 
            class="fluent-input"
            prefix-icon="el-icon-user"
          ></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input 
            type="password" 
            placeholder="密码" 
            v-model="ruleForm.password" 
            @keyup.enter="submitForm"
            class="fluent-input"
            prefix-icon="el-icon-lock"
          ></el-input>
        </el-form-item>
        <el-form-item>
          <el-button 
            class="fluent-btn fluent-btn-primary fluent-login-btn" 
            @click="submitForm"
          >
            登录
          </el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, ref, reactive } from "vue";
import mixin from "@/mixins/mixin";
import { HttpManager } from "@/api/index";
import { RouterName, MUSICNAME } from "@/enums";

export default defineComponent({
  setup() {
    const { proxy } = getCurrentInstance();
    const { routerManager } = mixin();

    const nusicName = ref(MUSICNAME);
    const isCardHovered = ref(false);
    const ruleForm = reactive({
      username: "admin",
      password: "123",
    });
    const rules = reactive({
      username: [{ required: true, message: "请输入用户名", trigger: "blur" }],
      password: [{ required: true, message: "请输入密码", trigger: "blur" }],
    });
    async function submitForm() {
      let username = ruleForm.username;
      let password = ruleForm.password;
      const result = (await HttpManager.getLoginStatus({username,password})) as ResponseBody;
      
      if (result.success) {
        // 保存admin token
        localStorage.setItem('admin_token', result.data.token);
        localStorage.setItem('adminId', result.data.adminInfo.id);
        
        // 更新状态
        proxy.$store.commit("setUsername", result.data.adminInfo.name);
        proxy.$store.commit("setId", result.data.adminInfo.id);
        
        routerManager(RouterName.Info, { path: RouterName.Info });
      }
      
      (proxy as any).$message({
        message: result.message,
        type: result.type,
        customClass: 'fluent-message'
      });
    }
    return {
      nusicName,
      isCardHovered,
      ruleForm,
      rules,
      submitForm,
    };
  },
});
</script>

<style scoped>
/* 登录页特定样式 - 覆盖全局样式 */
.fluent-login-container {
  position: relative;
  width: 100%;
  height: 100%;
  background: url("../assets/images/bg.jpg");
  background-attachment: fixed;
  background-position: center;
  background-size: cover;
  transition: all 0.5s ease-out;
  /* 覆盖全局样式中的flex布局 */
  display: block;
  align-items: initial;
  justify-content: initial;
}

.fluent-login-container::before {
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.2);
  transition: all 0.5s ease-out;
}

/* 登录框悬停时背景模糊放大效果 */
.blur-background {
  transform: scale(1.03);
}

.blur-background::before {
  backdrop-filter: blur(3px);
  background-color: rgba(0, 0, 0, 0.15);
}

/* 覆盖全局登录卡片样式 */
.fluent-login-card {
  position: absolute;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
  /* 其他样式继承自全局.fluent-login-card */
  animation: fadeIn 0.6s ease-out;
  z-index: 1;
}

.fluent-login-card:hover {
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
  transform: translate(-50%, -51%);
}

/* 登录卡片内的标题和副标题调整 */
.fluent-login-title {
  margin-bottom: 8px;
}

.fluent-login-subtitle {
  margin-bottom: 24px;
}

/* 动画 */
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translate(-50%, -48%);
  }
  to {
    opacity: 1;
    transform: translate(-50%, -50%);
  }
}

/* 响应式设计微调 */
@media (max-width: 768px) {
  .fluent-login-card {
    width: 85%;
  }
}
</style>
