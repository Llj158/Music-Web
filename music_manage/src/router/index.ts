import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
import { ElMessage } from 'element-plus'

const routes: Array<RouteRecordRaw> = [
  {
    path: '/Home',
    component: () => import('@/views/Home.vue'),
    meta: { requireAuth: true },
    children: [
      {
        path: '/Info',
        component: () => import('@/views/InfoPage.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/song',
        component: () => import('@/views/SongPage.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/singer',
        component: () => import('@/views/SingerPage.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/SongList',
        component: () => import('@/views/SongListPage.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/ListSong',
        component: () => import('@/views/ListSongPage.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/Comment',
        component: () => import('@/views/CommentPage.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/Consumer',
        component: () => import('@/views/ConsumerPage.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/Collect',
        component: () => import('@/views/CollectPage.vue'),
        meta: { requireAuth: true }
      },
      {
        path: '/song-manage',
        component: () => import('@/views/SongManage.vue'),
        meta: { requireAuth: true }
      }
    ]
  },
  {
    path: '/',
    component: () => import('@/views/Login.vue')
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

router.beforeEach((to, from, next) => {
  const token = localStorage.getItem('admin_token')

  if (to.matched.some(record => record.meta.requireAuth)) {
    if (!token) {
      ElMessage.warning('请先登录')
      next({
        path: '/',
        query: { redirect: to.fullPath }
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

export default router
