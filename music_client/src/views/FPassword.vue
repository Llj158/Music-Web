<template>
  <div class="page-container">
    <login-logo></login-logo>
    <div class="sign">
      <div class="sign-container login-container">
        <div class="sign-head">
          <span class="left-align">重置密码</span>
        </div>
        <el-form ref="resetForm" status-icon class="fluent-form">
          <el-form-item prop="email">
            <el-input v-model="email" placeholder="邮箱" class="fluent-input">
              <template #prefix>
                <svg-icon icon-class="email" class="input-icon"></svg-icon>
              </template>
            </el-input>
            <div class="verification-code-row">
              <el-button @click="sendVerificationCode" class="secondary-btn verification-button">发送验证码</el-button>
            </div>
          </el-form-item>
          <el-form-item prop="code">
            <el-input v-model="code" placeholder="验证码" class="fluent-input">
              <template #prefix>
                <svg-icon icon-class="password" class="input-icon"></svg-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input v-model="password" type="password" placeholder="新密码" class="fluent-input">
              <template #prefix>
                <svg-icon icon-class="password" class="input-icon"></svg-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item prop="confirmPassword">
            <el-input v-model="confirmPassword" type="password" placeholder="确认密码" class="fluent-input">
              <template #prefix>
                <svg-icon icon-class="password" class="input-icon"></svg-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item class="sign-btn">
            <el-button @click="goBack" class="secondary-btn">取消</el-button>
            <el-button type="primary" @click="handleSubmit" class="primary-btn">提交</el-button>
          </el-form-item>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, ref } from 'vue';
import { ElMessage } from 'element-plus';
import LoginLogo from "@/components/layouts/LoginLogo.vue";
import axios from 'axios';
import { useRouter } from 'vue-router';

export default defineComponent({
  components: {
    LoginLogo,
  },
  setup() {
    const email = ref("");
    const code = ref("");
    const password = ref("");
    const confirmPassword = ref("");
    const router = useRouter();

    const sendVerificationCode = async () => {
      if (!email.value) {
        ElMessage({
          message: '请输入邮箱',
          type: 'warning'
        });
        return;
      }
      
      try {
        const response = await axios.get('http://localhost:8888/user/sendVerificationCode', {
          params: {
            email: email.value
          }
        });
        ElMessage({
          message: response.data,
          type: 'success',
          customClass: 'fluent-message'
        });
      } catch (error) {
        console.error('发送验证码错误:', error);
        ElMessage({
          message: '发送验证码失败',
          type: 'error',
          customClass: 'fluent-message'
        });
      }
    };

    const handleSubmit = async () => {
      // 表单验证
      if (!email.value || !code.value || !password.value || !confirmPassword.value) {
        ElMessage({
          message: '请填写所有字段',
          type: 'warning',
          customClass: 'fluent-message'
        });
        return;
      }
      
      if (password.value !== confirmPassword.value) {
        ElMessage({
          message: '两次密码输入不一致',
          type: 'warning',
          customClass: 'fluent-message'
        });
        return;
      }

      try {
        const data = {
          email: email.value,
          code: code.value,
          password: password.value,
          confirmPassword: confirmPassword.value
        };
        
        const response = await axios.post('http://localhost:8888/user/resetPassword', data);
        
        ElMessage({
          message: response.data,
          type: 'success',
          customClass: 'fluent-message'
        });
        
        // 重置成功后跳转到登录页
        setTimeout(() => {
          router.push({ name: "sign-in" });
        }, 1500);
        
      } catch (error) {
        ElMessage({
          message: '重置密码失败',
          type: 'error',
          customClass: 'fluent-message'
        });
      }
    };
    
    const goBack = () => {
      router.push({ name: "sign-in" });
    };

    return {
      email,
      code,
      password,
      confirmPassword,
      sendVerificationCode,
      handleSubmit,
      goBack
    };
  }
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/auth-pages.scss";

.verification-code-row {
  display: flex;
  justify-content: flex-end;
  margin-top: 10px;
  
  .verification-button {
    width: 120px;
    height: 36px;
    font-size: 14px;
  }
}
</style>
