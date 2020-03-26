import Vue from 'vue'
import App from './App.vue'
import router from './router'

Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')

// Update page title
router.beforeEach((to, from, next) => {
  if (to.meta.auth === 1 && localStorage.loginToken === undefined) {
    // TODO: Redirect to /login here
    //       Probably change to.meta.auth too
  }

  document.title = to.meta.title ? to.meta.title : document.title;
  next();
})
