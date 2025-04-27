<template>
  <div class="page-container">
    <login-logo></login-logo>
    <div class="sign">
      <div class="sign-container login-container">
        <div class="sign-head">
          <span class="left-align">帐号登录</span>
        </div>
        <el-form ref="signInForm" status-icon :model="registerForm" :rules="SignInRules" class="standard-form">
          <el-form-item prop="username">
            <el-input placeholder="用户名" v-model="registerForm.username">
              <template #prefix>
                <svg-icon icon-class="user" class="input-icon"></svg-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input type="password" placeholder="密码" v-model="registerForm.password" @keyup.enter="handleLoginIn">
              <template #prefix>
                <svg-icon icon-class="password" class="input-icon"></svg-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item class="sign-btn">
            <el-button @click="handleSignUp" class="secondary-btn">注册</el-button>
            <el-button type="primary" @click="handleLoginIn" class="primary-btn">登录</el-button>
          </el-form-item>
          <div class="additional-options">
            <el-button type="text" @click="handleForgotPassword">忘记密码</el-button>
            <el-button type="text" @click="handleEmail">邮箱登录</el-button>
          </div>
        </el-form>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, reactive, getCurrentInstance } from "vue";
import mixin from "@/mixins/mixin";
import LoginLogo from "@/components/layouts/LoginLogo.vue";
import { HttpManager } from "@/api";
import { NavName, RouterName, SignInRules } from "@/enums";

export default defineComponent({
  components: {
    LoginLogo,
  },
  setup() {
    const { proxy } = getCurrentInstance();
    const { routerManager, changeIndex } = mixin();

    // 登录用户名密码
    const registerForm = reactive({
      username: "",
      password: "",
    });

    async function handleLoginIn() {
      let canRun = true;
      (proxy.$refs["signInForm"] as any).validate((valid) => {
        if (!valid) return (canRun = false);
      });
      if (!canRun) return;


      try {
        const username = registerForm.username;
        const password = registerForm.password;
        const result = (await HttpManager.signIn({username,password})) as ResponseBody;
        (proxy as any).$message({
          message: result.message,
          type: result.type,
        });

        if (result.success) {
          // 保存token到localStorage
          localStorage.setItem('token', result.data.token);
          localStorage.setItem('userId', result.data.userInfo.id);
          
          // 更新Vuex状态
          proxy.$store.commit("setUserId", result.data.userInfo.id);
          proxy.$store.commit("setUsername", result.data.userInfo.username);
          proxy.$store.commit("setUserPic", result.data.userInfo.avator);
          proxy.$store.commit("setToken", true);
          
          changeIndex(NavName.Home);
          routerManager(RouterName.Home, { path: RouterName.Home });
        }
      } catch (error) {
        console.error(error);
      }
    }

    function handleSignUp() {
      routerManager(RouterName.SignUp, { path: RouterName.SignUp });
    }

     function handleForgotPassword() {
      routerManager(RouterName.ForgotPassword, { path: RouterName.ForgotPassword });
    }
    function handleEmail() {
      routerManager(RouterName.loginByemail, { path: RouterName.loginByemail });
    }


    return {
      registerForm,
      SignInRules,
      handleLoginIn,
      handleForgotPassword,
      handleEmail,
      handleSignUp,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/auth-pages.scss";
</style>
