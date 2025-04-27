<template>
  <div class="password-change">
    <h2 class="section-title">更改密码</h2>
    <p class="section-desc">请输入您的旧密码和新密码</p>
    
    <el-form ref="passwordForm" label-width="80px" :model="form" :rules="rules" class="fluent-form">
      <el-form-item label="旧密码" prop="oldPassword">
        <el-input type="password" v-model="form.oldPassword" class="fluent-input" placeholder="请输入当前密码" />
      </el-form-item>
      <el-form-item label="新密码" prop="newPassword">
        <el-input type="password" v-model="form.newPassword" class="fluent-input" placeholder="请输入6位以上的新密码" show-password />
      </el-form-item>
      <el-form-item label="密码确认" prop="confirmPassword">
        <el-input type="password" v-model="form.confirmPassword" class="fluent-input" placeholder="请再次输入新密码" show-password />
      </el-form-item>
      <el-form-item class="form-actions">
        <el-button @click="clearData()" class="reset-button">重置</el-button>
        <el-button type="primary" @click="confirm()" class="confirm-button">确认修改</el-button>
      </el-form-item>
    </el-form>
    
    <div class="password-tips">
      <h3>密码安全提示</h3>
      <ul>
        <li>建议使用字母、数字和特殊字符的组合</li>
        <li>请勿使用与其他网站相同的密码</li>
      </ul>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, computed, reactive } from "vue";
import { useStore } from "vuex";
import mixin from "@/mixins/mixin";
import { HttpManager } from "@/api";
import { validatePassword } from "@/enums";

export default defineComponent({
  setup() {
    const store = useStore();
    const { proxy } = getCurrentInstance();
    const { goBack } = mixin();

    const form = reactive({
      oldPassword: "",
      newPassword: "",
      confirmPassword: "",
    });
    const userId = computed(() => store.getters.userId);
    const userName = computed(() => store.getters.username);

    const validateCheck = (rule: any, value: any, callback: any) => {
      if (value === "") {
        callback(new Error("密码不能为空"));
      } else if (value !== form.newPassword) {
        callback(new Error("两次输入的密码不一致"));
      } else {
        callback();
      }
    };
    const rules = reactive({
      oldPassword: [{ validator: validatePassword, trigger: "blur", min: 3 }],
      newPassword: [{ validator: validatePassword, trigger: "blur", min: 3 }],
      confirmPassword: [{ validator: validateCheck, trigger: "blur", min: 3 }],
    });

    async function clearData() {
      form.oldPassword = "";
      form.newPassword = "";
      form.confirmPassword = "";
    }

    async function confirm() {
      let canRun = true;
      (proxy.$refs["passwordForm"] as any).validate((valid) => {
        if (!valid) return (canRun = false);
      });
      if (!canRun) return;


      const id = userId.value;
      const username = userName.value;
      const oldPassword = form.oldPassword;
      const password = form.newPassword;

      const result = (await HttpManager.updateUserPassword({id,username,oldPassword,password})) as ResponseBody;
      (proxy as any).$message({
        message: result.message,
        type: result.type,
        customClass: 'fluent-message'
      });
      if (result.success) goBack();
    }

    return {
      form,
      clearData,
      confirm,
      rules,
    };
  },
});
</script>

<style lang="scss" scoped>
@import "@/assets/css/var.scss";

.password-change {
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
  
  :deep(.fluent-input .el-input__wrapper) {
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
}

.form-actions {
  margin-top: 30px;
  display: flex;
  justify-content: flex-end;
  
  :deep(.el-form-item__content) {
    justify-content: flex-end;
  }
  
  .reset-button {
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
  
  .confirm-button {
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

.password-tips {
  margin-top: 40px;
  padding: 20px;
  border-radius: 8px;
  background-color: rgba(0, 120, 212, 0.05);
  border: 1px solid rgba(0, 120, 212, 0.1);
  
  h3 {
    font-size: 16px;
    font-weight: 600;
    color: rgba(0, 0, 0, 0.85);
    margin-top: 0;
    margin-bottom: 12px;
  }
  
  ul {
    margin: 0;
    padding-left: 20px;
    
    li {
      color: rgba(0, 0, 0, 0.65);
      margin-bottom: 6px;
      font-size: 14px;
      
      &:last-child {
        margin-bottom: 0;
      }
    }
  }
}
</style>
