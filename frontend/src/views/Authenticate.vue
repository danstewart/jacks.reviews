<template>
  <div class="authenticate">
    <!-- Blank page used to set token then redirect to home page -->
  </div>
</template>

<<script>
import redirects from '@/mixins/redirects'

export default {
  name: 'authenticate',
  mixins: [redirects],
  
  created() {
    // TODO: Add a goto param to redirect to the last page before logging in
    localStorage.setItem('loginToken', this.$route.query.token);

    // This will update the navbar to show Add instead of Login
    // Without this we need to refresh the page
    this.$parent.loggedIn = true;

    // Redirect to home
    this.redirect('/', 'Successfully logged in', 'success');
  },
}
</script>