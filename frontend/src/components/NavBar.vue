<template>
  <nav class='navbar' role='navigation' aria-label='main navigation'>
    <div class='navbar-brand'>
      <a class='navbar-item' href='/'>
        <div class='logo'>
          <span class='main'>JACKS</span>&nbsp;<span class='light'>REVIEWS</span>
        </div>
      </a>
      <a role='button' class='navbar-burger' data-target='navMenu' aria-label='menu' aria-expanded='false'>
      <span aria-hidden='true'></span>
      <span aria-hidden='true'></span>
      <span aria-hidden='true'></span>
      </a>
    </div>

    <div class='navbar-menu' id='navMenu'>
      <div class='navbar-start'>
        <router-link to='/' class='navbar-item'>
          <span><i class='fas fa-home'/>Home</span>
        </router-link>

        <router-link v-if='loggedIn' to='/add' class='navbar-item'>
          <span><i class='fas fa-plus'/>Add</span>
        </router-link>
        
        <router-link v-else to='/login' class='navbar-item'>
          <span><i class='fas fa-sign-in-alt'/>Login</span>
        </router-link>
      </div>

      <div class='navbar-end'>
        <a class='navbar-item' href='https://letterboxd.com/Jack_McLean' target="_blank" rel="noopener noreferrer">
          <span><i class='fas fa-film'/>Letterboxd</span>
        </a>
        <a class='navbar-item' href='https://twitter.com/mad_mclean' target="_blank" rel="noopener noreferrer">
          <span><i class='fab fa-twitter'/>Twitter</span>
        </a>
        <a class='navbar-item' href='https://www.instagram.com/blu_ray_jimmy' target="_blank" rel="noopener noreferrer">
          <span><i class='fab fa-instagram'/>Instagram</span>
        </a>
      </div>
    </div>
  </nav>
</template>
<script>

export default {
  name: 'NavBar',

  props: {
    loggedIn: {
      type: Boolean,
      required: true,
    },
  },

  mounted() {
    document.addEventListener('DOMContentLoaded', this.handleHamburger);
  },

  methods: {
    handleHamburger() {
      let navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

      navbarBurgers.forEach(function (el) {
        el.addEventListener('click', function () {

          let item = el.dataset.target;
          item = document.getElementById(item);

          el.classList.toggle('is-active');
          item.classList.toggle('is-active');

        });
      });
    },
  }
}
</script>

<style scoped>
.fas, .fab {
  margin-right: 10px;
}

.logo {
  line-height: 20px;
}

.main {
  font-size: 2em;
  font-weight: bold;
  font-family: 'Source Code Pro', monospace;
}

.light {
  font-size: 1em;
  font-family: 'Source Sans Pro', sans-serif;
  vertical-align: bottom;
}

.navbar-end { 
  padding-right: 20px;
}

</style>

