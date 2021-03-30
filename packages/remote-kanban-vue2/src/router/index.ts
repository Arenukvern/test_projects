import { RoutesPaths } from '@/constants/RoutesPaths'
import { getToken } from '@/functions/getToken'
import { ViewsRouter } from '@/viewsRouter'
import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'

Vue.use(VueRouter)

const routes: Array<RouteConfig> = [
  {
    path: RoutesPaths.home,
    name: 'Home',
    component: ViewsRouter.Home,
    meta: {
      requireAuth: true,
    },
  },
  {
    path: RoutesPaths.auth,
    name: 'Auth',
    component: ViewsRouter.Auth,
    meta: {
      guest: true,
    },
  },
]

const router = new VueRouter({
  routes,
})

router.beforeEach(async (to, from, next) => {
  const go = (path: string) => {
    next({
      path,
      params: { nextUrl: to.fullPath },
    })
  }
  const goAuth = () => go(RoutesPaths.auth)
  const token = getToken()
  const isTokenNull = token === null
  const checkToken = async () => {
    //
  }
  if (to.matched.some(record => record.meta.requireAuth)) {
    console.log('reqiure auth', { isTokenNull })
    if (isTokenNull) {
      await checkToken()
      goAuth()
      return
    } else {
      await checkToken()
      next()
      return
    }
  }
  next()
})

export default router
