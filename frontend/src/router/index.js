import { createRouter, createWebHashHistory } from 'vue-router'
import DashboardView from '@/views/DashboardView.vue'
import AssignDutiesView from '@/views/AssignDutiesView.vue'
import OfficerDutiesView from '@/views/OfficerDutiesView.vue'
import SettingsView from '@/views/SettingsView.vue'
import LoginView from '@/views/LoginView.vue'

const routes = [
  {
    path: '/',
    name: 'dashboard',
    component: DashboardView,
    meta: { requiresAuth: true,  title: 'IPCR - Dashboard' } 
  },
  {
    path: '/assigned-duties',
    name: 'assigned-duties',
    component: AssignDutiesView, 
    meta: { requiresAuth: true,  title: 'IPCR - Assign Duties' } 
  },
  {
    path: '/officers-duties',
    name: 'officers-duties',
    component: OfficerDutiesView,
    meta: { requiresAuth: true,  title: 'IPCR - Officer Duties' }  
  },
  {
    path: '/settings',
    name: 'settings',
    component: SettingsView,
    meta: { requiresAuth: true,  title: 'IPCR - Settings' }  
  },
  {
    path: '/login',
    name: 'login',
    component: LoginView
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('authToken');
  const title = to.meta.title || 'IPCR Excel Maker';
  if (to.meta.requiresAuth && !token) {
    document.title = title;
    next('/login');
  } else if (to.path === '/login' && token){
    document.title = title;
    next('/');
  } else {
    document.title = title;
    next();
  }
});

export default router
