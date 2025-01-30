import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import axios from 'axios';
import 'materialize-css/dist/css/materialize.min.css';
import 'materialize-css/dist/js/materialize.min.js';

// Configure Axios
axios.defaults.baseURL = "http://127.0.0.1:8000/api";
axios.defaults.withCredentials = true;

// Interceptor to dynamically set the Authorization header
axios.interceptors.request.use((config) => {
const token = localStorage.getItem('authToken');
if (token) {
    config.headers['Authorization'] = `Bearer ${token}`;
}
    return config;

}, (error) => {
    return Promise.reject(error);
});

const app = createApp(App);

// Attach Axios globally
app.config.globalProperties.$axios = axios;

// Mount the app
app.use(store).use(router).mount('#app');
