import Vue from 'vue'
import Router from 'vue-router'
import Home from './views/Home.vue'
import Add from './views/Add.vue'
import Edit from './views/Edit.vue'
import Login from './views/Login.vue'
import Authenticate from './views/Authenticate.vue'

Vue.use(Router)

document.title = 'Jacks Reviews';

export default new Router({
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home,
      meta: { title: `${document.title}` },
    },
    {
      path: '/add',
      name: 'add',
      component: Add,
      meta: { title: `${document.title} | Add`, auth: 1 },
    },
    {
      path: '/edit/:id',
      name: 'edit',
      component: Edit,
      meta: { title: `${document.title} | Edit`, auth: 1 },
    },
    {
      path: '/login',
      name: 'login',
      component: Login,
      meta: { title: `${document.title} | Login` }
    },
    {
      path: '/authenticate',
      name: 'authenticate',
      component: Authenticate,
      meta: { title: `${document.title} | Authenticate` }
    }
  ]
})
