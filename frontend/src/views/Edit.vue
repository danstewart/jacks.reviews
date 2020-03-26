<template>
  <div class='edit field'>
    <div class='column'>
      <h1 class='subtitle'><b>Edit review</b></h1>
      <movie-review v-if='loaded'
        :defMovie='movie'
        :defTags='tags'
        :defReview='review'
        :defRating='rating'
        @submit='submit'
      ></movie-review>
    </div>
  </div>
</template>


<script>
import MovieReview from '@/components/forms/MovieReview.vue'
import api from '@/mixins/api'
import redirects from '@/mixins/redirects'

export default {
  name: 'edit',
  mixins: [api, redirects],

  data() {
    return {
      movie:  {},
      tags:   [],
      review: '',
      rating: '',
      loaded: false,
    }
  },

  components: {
    MovieReview
  },

  methods: {
    submit(movie) {
      this.put(`/movies/${movie.id}`, { auth: true, params: movie })
        .then(res => this.redirect('/', 'Successfully updated review', 'success'))
    }
  },

  mounted() {
    if (this.$route.params.id) {
      // Do request for movie
      this.get(`/movies/${this.$route.params.id}`).then(res => { 
        let data = res.data

        this.movie  = { id: data.id, tmdb_id: data.tmdb_id, name: data.title }
        this.rating = data.rating
        this.review = data.review
        this.tags   = data.tags

        this.loaded = true
      })
    }
  }
}
</script>

<style scoped>
</style>
