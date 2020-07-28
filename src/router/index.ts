import { ViewsRouter } from '@/viewsRouter'
import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'

Vue.use(VueRouter)

const routes: Array<RouteConfig> = [
  {
    path: '/',
    name: 'Home',
    component: ViewsRouter.Home,
  },
  {
    path: '/auth',
    name: 'Auth',
    component: ViewsRouter.Auth,
  },
]

const router = new VueRouter({
  routes,
})

export default router
