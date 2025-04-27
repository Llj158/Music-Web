<template>
  <div>
    <!-- 删除提示框 -->
    <el-dialog 
      title="删除确认" 
      v-model="centerDialogVisible" 
      width="350px" 
      center
      class="fluent-dialog"
      :close-on-click-modal="false"
      :show-close="false">
      <div class="fluent-dialog-content" align="center">
        <el-icon class="fluent-warning-icon"><WarningFilled /></el-icon>
        <p>删除不可恢复，是否确定删除？</p>
      </div>
      <template #footer>
        <div class="fluent-dialog-footer">
          <el-button @click="cancelRow" class="fluent-btn fluent-btn-secondary">取 消</el-button>
          <el-button type="primary" @click="confirm" class="fluent-btn fluent-btn-primary">确 定</el-button>
        </div>
      </template>
    </el-dialog>
  </div>
</template>

<script lang="ts">
import { defineComponent, getCurrentInstance, toRefs, watch, ref } from "vue";
import { WarningFilled } from '@element-plus/icons-vue';

export default defineComponent({
  components: {
    WarningFilled
  },
  props: {
    delVisible: Boolean,
  },
  emits: ["cancelRow", "confirm"],
  setup(props) {
    const { proxy } = getCurrentInstance();

    const { delVisible } = toRefs(props);
    const centerDialogVisible = ref(delVisible.value);

    watch(delVisible, (value) => {
      centerDialogVisible.value = value;
    });

    function cancelRow() {
      proxy.$emit("cancelRow", false);
    }
    function confirm() {
      proxy.$emit("confirm", null);
    }
    return {
      centerDialogVisible,
      cancelRow,
      confirm,
    };
  },
});
</script>

<style scoped>
.fluent-dialog :deep(.el-dialog) {
  border-radius: 8px;
  box-shadow: 0 4px 16px rgba(0, 0, 0, 0.1);
  overflow: hidden;
}

.fluent-dialog :deep(.el-dialog__header) {
  background-color: var(--fluent-background);
  padding: 15px 20px;
  margin: 0;
  border-bottom: 1px solid var(--fluent-border-color, #ebeef5);
}

.fluent-dialog :deep(.el-dialog__title) {
  color: var(--fluent-text-primary);
  font-weight: 600;
  font-size: 16px;
}

.fluent-dialog-content {
  padding: 25px 20px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.fluent-warning-icon {
  font-size: 36px;
  color: #e6a23c;
  margin-bottom: 15px;
}

.fluent-dialog-content p {
  margin: 0;
  color: var(--fluent-text-primary);
  font-size: 15px;
}

.fluent-dialog-footer {
  display: flex;
  justify-content: center;
  gap: 15px;
  padding: 10px 0;
}

.fluent-btn {
  border: none;
  padding: 10px 20px;
  border-radius: 4px;
  cursor: pointer;
  font-size: 14px;
}

.fluent-btn-primary {
  background-color: var(--fluent-primary);
  color: var(--fluent-text-on-primary);
}

.fluent-btn-secondary {
  background-color: var(--fluent-secondary);
  color: var(--fluent-text-on-secondary);
}
</style>
