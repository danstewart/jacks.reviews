<template>
  <div class='add'>
    <h1 class='title'>Login</h1>
    <h4 class='subtitle'>It doesn't look like you're currently logged in, just enter your email below and we'll send you a magic login link.</h4>
    <br />

    <div class='columns'>
      <div class='column is-one-quarter'>
        <label class='label' for='name'>Name</label>
        <input class='input' id='name' v-model.trim='name' type='text' />
      </div>
      <div class='column'>
        <label class='label' for='email'>Email</label>
        <input class='input' id='email' v-model.trim='email' type='email' />
      </div>
    </div>
    <button class='button is-primary' id='submitForm' type='submit' @click='submit'>Submit</button>
  </div>
</template>

<script>
import redirects from '@/mixins/redirects'
import api from '@/mixins/api'

export default {
  name: 'login',
  mixins: [api, redirects],

  data() {
    return {
      name: '',
      email: '',
    }
  },

  props: {
    loggedIn: {
      type: Boolean,
      required: true,
    },
  },

  created() {
    if (this.loggedIn && localStorage.getItem('loginToken')) {
      this.redirect('/', "You're already logged in", 'info');
    }
  },
  
  methods: {
    submit() {
      let user = {
        name: this.name,
        email: this.email,
      };

      this.post('/auth/login', { params: user })
        .then(res => this.redirect('/', "We've sent you a login email, check your inbox!", 'info'))
    },
  }
}
</script>