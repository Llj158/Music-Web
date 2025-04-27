import { createApp } from "vue";
import ElementPlus from "element-plus";
import App from "./App.vue";
import router from "./router";
import store from "./store";
import "element-plus/dist/index.css";
import "@/assets/css/main.css";
import "@/assets/css/fluent.css";
import "./assets/icons/iconfont.js";
import { Buffer } from "buffer";

import { Store } from "vuex";
declare module "@vue/runtime-core" {
  interface State {
    count: number;
  }

  interface ComponentCustomProperties {
    $store: Store<State>;
  }
}

globalThis.Buffer = Buffer;

const app = createApp(App);

app.use(store).use(router).use(ElementPlus);
app.mount("#app");
