<template>
  <div id='app'>
    <div id='body'>
      <meta name='viewport' content='width=device-width, initial-scale=1'>
      <nav-bar :loggedIn='loggedIn'></nav-bar><br>

      <div class='container'>
        <router-view :loggedIn='loggedIn'/>
      </div>
    </div>

    <footer class='footer'>
      <div class='content has-text-centered'>
        <a href='https://www.themoviedb.org/'>
          <img id='tmdb-logo' src='https://www.themoviedb.org/assets/2/v4/logos/v2/blue_short-8e7b30f73a4020692ccca9c88bafe5dcb6f8a62a4c6bc55cd9ba82bb2cd95f6c.svg' alt='TMDb Logo'>
        </a>
        <p>This product uses the TMDb API but is not endorsed or certified by TMDb.</p>
      </div>
    </footer>

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
  }

  #body {
    margin-bottom: 100px;
  }

  a {
    -webkit-user-select: none;
    -moz-user-select: none;
    -khtml-user-select: none;
    -ms-user-select: none;
  }

  .footer {
    color: lightgrey !important;
    padding: 3rem 1.5rem !important;
  }

  #tmdb-logo {
    width: auto;
    height: 15px;
  }
</style>
