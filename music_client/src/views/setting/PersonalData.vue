<template>
  <div class="personal-data">
    <h2 class="section-title">个人资料</h2>
    <p class="section-desc">您可以更新个人资料信息</p>
    
    <el-form ref="updateForm" label-width="80px" :model="registerForm" :rules="SignUpRules" class="fluent-form">
      <el-form-item prop="username" label="用户名">
        <el-input v-model="registerForm.username" placeholder="用户名" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item label="性别" class="gender-group">
        <el-radio-group v-model="registerForm.sex" class="fluent-radio-group">
          <el-radio :label="0">女</el-radio>
          <el-radio :label="1">男</el-radio>
          <el-radio :label="2">保密</el-radio>
        </el-radio-group>
      </el-form-item>
      <el-form-item prop="birth" label="生日">
        <el-date-picker type="date" placeholder="选择日期" v-model="registerForm.birth" style="width: 100%" class="fluent-date-picker"></el-date-picker>
      </el-form-item>
      <el-form-item prop="introduction" label="签名">
        <el-input type="textarea" placeholder="签名" v-model="registerForm.introduction" class="fluent-textarea"></el-input>
      </el-form-item>
      <el-form-item prop="location" label="地区">
        <el-select v-model="registerForm.location" placeholder="地区" style="width: 100%" class="fluent-select">
          <el-option v-for="item in AREA" :key="item.value" :label="item.label" :value="item.value"> </el-option>
        </el-select>
      </el-form-item>
      <el-form-item prop="phoneNum" label="手机">
        <el-input placeholder="手机" v-model="registerForm.phoneNum" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item prop="email" label="邮箱">
        <el-input v-model="registerForm.email" placeholder="邮箱" class="fluent-input"></el-input>
      </el-form-item>
      <el-form-item class="form-actions">
        <el-button @click="goBack(-1)" class="cancel-button">取消</el-button>
        <el-button type="primary" @click="saveMsg()" class="save-button">保存</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script lang="ts">
import { defineComponent, computed, onMounted, getCurrentInstance, reactive } from "vue";
import { useStore } from "vuex";
import mixin from "@/mixins/mixin";
import { AREA, SignUpRules } from "@/enums";
import { HttpManager } from "@/api";
import { getBirth } from "@/utils";

export default defineComponent({
  setup() {
    const { proxy } = getCurrentInstance();
    const store = useStore();
    const { goBack } = mixin();

    // 注册
    const registerForm = reactive({
      username: "",
      sex: "",
      phoneNum: "",
      email: "",
      birth: new Date(),
      introduction: "",
      location: "",
      userPic: "",
    });
    const userId = computed(() => store.getters.userId);

    async function getUserInfo(id) {
      const result = (await HttpManager.getUserOfId(id)) as ResponseBody;
      registerForm.username = result.data[0].username;
      registerForm.sex = result.data[0].sex;
      registerForm.phoneNum = result.data[0].phoneNum;
      registerForm.email = result.data[0].email;
      registerForm.birth = result.data[0].birth;
      registerForm.introduction = result.data[0].introduction;
      registerForm.location = result.data[0].location;
      registerForm.userPic = result.data[0].avator;
    }

    async function saveMsg() {
      let canRun = true;
      (proxy.$refs["updateForm"] as any).validate((valid) => {
        if (!valid) return (canRun = false);
      });
      if (!canRun) return;


      const id = userId.value;
      const username = registerForm.username;
      const sex = registerForm.sex;
      const phoneNum = registerForm.phoneNum;
      const email = registerForm.email;
      const birth = registerForm.birth;
      const introduction = registerForm.introduction;
      const location = registerForm.location;
      const result = (await HttpManager.updateUserMsg({id,username,sex,phoneNum,email,birth,introduction,location})) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
        customClass: 'fluent-message'
      });
      if (result.success) {
        proxy.$store.commit("setUsername", registerForm.username);
        goBack(-1);
      }
    }

    onMounted(() => {
      getUserInfo(userId.value);
    });

    return {
      AREA,
      registerForm,
      SignUpRules,
      saveMsg,
      goBack,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.personal-data {
  text-align: left;
  max-width: 600px;
  margin: 0 auto;
  padding: 20px 0;
}

.section-title {
  font-size: 20px;
  font-weight: 600;
  color: rgba(0, 0, 0, 0.85);
  margin-bottom: 8px;
  margin-top: 0;
}

.section-desc {
  color: rgba(0, 0, 0, 0.6);
  margin-bottom: 30px;
  font-size: 14px;
}

.fluent-form {
  :deep(.el-form-item) {
    margin-bottom: 22px;
    
    .el-form-item__label {
      color: rgba(0, 0, 0, 0.75);
      font-weight: 500;
      font-size: 14px;
      padding-right: 15px;
    }
    
    .el-form-item__error {
      color: #d13438;
    }
  }
  
  :deep(.fluent-input .el-input__wrapper),
  :deep(.fluent-textarea .el-textarea__inner),
  :deep(.fluent-select .el-input__wrapper),
  :deep(.fluent-date-picker .el-input__wrapper) {
    border-radius: 6px;
    box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.1) inset;
    transition: all 0.3s ease;
    background-color: rgba(255, 255, 255, 0.8);
    
    &:hover {
      box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.2) inset;
    }
    
    &.is-focus {
      box-shadow: 0 0 0 2px $color-blue-active inset;
      background-color: white;
    }
  }
  
  :deep(.fluent-radio-group) {
    .el-radio {
      margin-right: 20px;
      
      .el-radio__label {
        color: rgba(0, 0, 0, 0.75);
      }
      
      .el-radio__input.is-checked .el-radio__inner {
        background-color: $color-blue-active;
        border-color: $color-blue-active;
      }
      
      .el-radio__input.is-checked + .el-radio__label {
        color: $color-blue-active;
      }
    }
  }
}

.form-actions {
  margin-top: 40px;
  display: flex;
  justify-content: flex-end;
  
  :deep(.el-form-item__content) {
    justify-content: flex-end;
  }
  
  .cancel-button {
    margin-right: 12px;
    background-color: transparent;
    border: 1px solid rgba(0, 0, 0, 0.15);
    color: rgba(0, 0, 0, 0.65);
    transition: all 0.3s ease;
    
    &:hover {
      background-color: rgba(0, 0, 0, 0.05);
      border-color: rgba(0, 0, 0, 0.25);
      color: rgba(0, 0, 0, 0.85);
    }
  }
  
  .save-button {
    background-color: $color-blue-active;
    border: none;
    transition: all 0.3s ease;
    
    &:hover {
      background-color: lighten($color-blue-active, 5%);
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba($color-blue-active, 0.3);
    }
    
    &:active {
      transform: translateY(0);
    }
  }
}
</style>
