import axios from "axios";
import router from "@/router";

const BASE_URL = process.env.NODE_HOST;

axios.defaults.timeout = 5000; // 超时时间设置
axios.defaults.withCredentials = true; // true允许跨域
axios.defaults.baseURL = BASE_URL;
// Content-Type 响应头
axios.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded;charset=UTF-8";

const request = axios.create({
  baseURL: process.env.VUE_APP_BASE_API,
  timeout: 5000
});

// 请求拦截器
request.interceptors.request.use(
  config => {
    // 从localStorage获取token替代session
    const token = localStorage.getItem('token');
    if (token) {
      config.headers['token'] = token;
    }
    return config;
  },
  error => {
    return Promise.reject(error);
  }
);

// 响应拦截器
request.interceptors.response.use(
  response => {
    return Promise.resolve(response.data);
  },
  error => {
    if (error.response && error.response.status) {
      switch (error.response.status) {
        case 401: // token过期或未登录
          localStorage.removeItem('token');
          router.replace('/sign-in');
          break;
        case 403: // 权限不足
          localStorage.removeItem('token');
          router.replace('/sign-in');
          break;
      }
    }
    return Promise.reject(error);
  }
);

export function getBaseURL() {
  return BASE_URL;
}

/**
 * 封装get方法
 * @param url
 * @param data
 * @returns {Promise}
 */
export function get(url, params?: object) {
  return new Promise((resolve, reject) => {
    request.get(url, { params }).then(
      (response) => resolve(response),
      (error) => reject(error)
    );
  });
}

/**
 * 封装post请求
 * @param url
 * @param data
 * @param config
 * @returns {Promise}
 */
export function post(url, data = {}, config = {}) {
  return new Promise((resolve, reject) => {
    request.post(url, data, config).then(
      (response) => resolve(response),
      (error) => reject(error)
    );
  });
}

/**
 * 封装delete请求
 * @param url
 * @param data
 * @returns {Promise}
 */
export function deletes(url, data = {}) {
  return new Promise((resolve, reject) => {
    request.delete(url, data).then(
      (response) => resolve(response),
      (error) => reject(error)
    );
  });
}

/**
 * 封装put请求
 * @param url
 * @param data
 * @returns {Promise}
 */
export function put(url, data = {}) {
  return new Promise((resolve, reject) => {
    request.put(url, data).then(
      (response) => resolve(response),
      (error) => reject(error)
    );
  });
}

export default request;
