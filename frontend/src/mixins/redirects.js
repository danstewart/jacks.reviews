import nativeToast  from 'native-toast';

export default {
  methods: {
    redirect(to, msg = '', type = 'info') {
      if (msg) {
        nativeToast({
          message: msg,
          position: 'top',
          timeout: 2500,
          type: type,
          closeOnClick: true,
        });
      }

      this.$router.push(to);
    },

    login(to, msg, type) {
      this.redirect('/login', 'You need to log in first', 'info');
    }
  }
}