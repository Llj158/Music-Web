<template>
  <div class="logo-container">
    <div class="logo-wrapper">
      <mus-icon :icon="icon" class="logo-icon"></mus-icon>
      <div class="logo-text">
        <h1>Music</h1>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import MusIcon from "./Icon.vue";
import { Icon } from "@/enums";

export default defineComponent({
  components: {
    MusIcon,
  },
  data() {
    return {
      icon: Icon.ERJI,
    };
  },
});
</script>

<style lang="scss" scoped>
.logo-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 40px 0;
  
  .logo-wrapper {
    display: flex;
    align-items: center;
    animation: fadeIn 1s ease;
    
    .logo-icon {
      width: 50px;
      height: 50px;
      color: #86bef7;
      margin-right: 15px;
      animation: pulse 3s infinite ease-in-out;
    }
    
    .logo-text {
      display: flex;
      flex-direction: column;
      
      h1 {
        font-size: 28px;
        font-weight: 600;
        margin: 0;
        color: rgb(38, 38, 38);
        letter-spacing: 1px;
      }
      
    }
  }
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@keyframes pulse {
  0% {
    transform: scale(1);
  }
  50% {
    transform: scale(1.08);
  }
  100% {
    transform: scale(1);
  }
}

@media screen and (max-width: 768px) {
  .logo-container {
    padding: 20px 0;
    
    .logo-wrapper {
      .logo-icon {
        width: 40px;
        height: 40px;
      }
      
      .logo-text {
        h1 {
          font-size: 22px;
        }
        
        p {
          font-size: 12px;
        }
      }
    }
  }
}
</style>
