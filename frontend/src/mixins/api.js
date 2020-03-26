import axios from 'axios';
import { config } from '@/config.js'
import redirects from '@/mixins/redirects'

export default {
  mixins: [redirects],

  data() {
    return {
      endpoint: config.endpoint,
    }
  },

  methods: {
    parseOpts(opts) {
      opts.headers = opts.headers || {}
      opts.params  = opts.params  || {}

      if (opts.auth) {
        let token = localStorage.getItem('loginToken')
        opts.headers['Authorization'] = `Bearer ${token}`
      }

      return opts
    },

    get(path, opts = {}) {
      opts = this.parseOpts(opts)
      return axios.get(this.endpoint+path, { params: opts.params, headers: opts.headers })
        .catch(err => this.handleErr(err))
    },

    post(path, opts = {}) {
      opts = this.parseOpts(opts)
      return axios.post(this.endpoint+path, opts.params, { headers: opts.headers })
        .catch(err => this.handleErr(err))
    },

    put(path, opts = {}) {
      opts = this.parseOpts(opts)
      return axios.put(this.endpoint+path, opts.params, { headers: opts.headers })
        .catch(err => this.handleErr(err))
    },

    delete(path, opts = {}) {
      opts = this.parseOpts(opts)
      return axios.delete(this.endpoint+path, { headers: opts.headers })
        .catch(err => this.handleErr(err))
    },

    handleErr(err) {
      console.log('API error: ' + err);

      if (err.response) {
        let msg = err.response.data.message

        console.log('Error message: ' + msg)
        console.log('Error status:  ' + err.response.status)

        // If we have a bad token then remove it
        if (msg == 'Missing token' || msg == 'Expired token') {
          localStorage.removeItem('loginToken')
          this.redirect('/login', "Your login token has expired\nPlease log in again", 'warning')
        }

        if (msg == 'Invalid email')
          this.redirect('/', "Sorry, we didn't recognise your email", 'warning')
      }

      // Throw the error so the `.then` logic doesn't run
      throw err;
    },
  }
}