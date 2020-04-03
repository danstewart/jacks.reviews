<template>
  <div class='add field'>
    <div class='column'>
      <h1 class='subtitle'><b>Add a movie review</b></h1>
      <movie-review :defTags='[]' @submit='submit'></movie-review>
    </div>
  </div>
</template>


<script>
import MovieReview from '@/components/forms/MovieReview.vue'
import api from '@/mixins/api'
import redirects from '@/mixins/redirects'

export default {
  name: 'add',
  mixins: [api, redirects],

  components: {
    MovieReview
  },

  methods: {
    submit(movie) {
      this.post('/movies', { auth: true, params: movie })
        .then(res => this.redirect('/', 'Successfully added review', 'success'))
      }
  }
}
</script>

<style scoped>
</style>
