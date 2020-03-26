<template>
  <div id='app'>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <nav-bar :loggedIn='loggedIn'></nav-bar><br>

    <div class='container'>
      <router-view :loggedIn='loggedIn'/>
    </div>

    <link rel='stylesheet' href='https://unpkg.com/native-toast@1.3.0/dist/native-toast.css'>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
  </div>
</template>

<script>
import NavBar from '@/components/NavBar.vue'
require('@/assets/mystyles.css')

export default {
  name: 'App',

  data() {
    return {
      loggedIn: (localStorage.getItem('loginToken') !== null),
    }
  },

  components: {
    NavBar,
  },
}  
</script>

<style>
  #app {
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    line-height: 1.4;
    margin-bottom: 200px;
  }

  a {
    -webkit-user-select: none;
    -moz-user-select: none;
    -khtml-user-select: none;
    -ms-user-select: none;
  }
</style>
