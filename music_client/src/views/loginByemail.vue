<template>
  <div class="page-container">
    <login-logo></login-logo>
    <div class="sign">
      <div class="sign-container login-container">
        <div class="sign-head center-aligned">
          <span class="center-align">邮箱登录</span>
        </div>
        <el-form ref="signInForm" status-icon :model="registerForm" :rules="SignInRules" class="fluent-form">
          <el-form-item prop="email">
            <el-input placeholder="邮箱" v-model="registerForm.email" class="fluent-input">
              <template #prefix>
                <svg-icon icon-class="email" class="input-icon"></svg-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item prop="password">
            <el-input type="password" placeholder="密码" v-model="registerForm.password" @keyup.enter="handleLoginIn" class="fluent-input">
              <template #prefix>
                <svg-icon icon-class="password" class="input-icon"></svg-icon>
              </template>
            </el-input>
          </el-form-item>
          <el-form-item class="sign-btn">
            <el-button type="primary" @click="handleLoginIn" class="primary-btn">登录</el-button>
            <el-button @click="handleLoginCancel" class="secondary-btn">取消</el-button>
          </el-form-item>
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

    // 登录
    const registerForm = reactive({
      email: "",
      password: "",
    });

    async function handleLoginCancel() {
       routerManager(RouterName.SignIn, { path: RouterName.SignIn });
    }

    async function handleLoginIn() {
      let canRun = true;
      (proxy.$refs["signInForm"] as any).validate((valid) => {
        if (!valid) return (canRun = false);
      });
      if (!canRun) return;


      try {
        const email = registerForm.email;
        const password = registerForm.password;
        const result = (await HttpManager.signInByemail({email,password})) as ResponseBody;
        (proxy as any).$message({
          message: result.message,
          type: result.type,
          customClass: 'fluent-message'
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

    return {
      registerForm,
      SignInRules,
      handleLoginIn,
      handleLoginCancel,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/auth-pages.scss";
</style>
