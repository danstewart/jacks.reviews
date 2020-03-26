<template>
  <div class='movie-review'>
    <div class='columns'>
      <div class='column control'>
        <label class='label' for='movieName'>Name</label>
        <auto-complete 
          source='movies'
          @selectItem='selectMovie'
          @getResults='findMovies'
          :list='movieList'
          v-model='movie'
        />  
      </div>

      <div class='column control'>
        <label class='label' for='rating'>Rating</label>
        <span class='select is-fullwidth'>
          <select id='rating' required v-model='rating'>
            <option value='' disabled selected hidden>Was it any good?</option>
            <option v-for='rating in ratings' :key='rating'>{{ rating }}</option>
          </select>
        </span>
      </div>
    </div>

    <div class='control'>
      <label class='label' for='review'>Full Review</label>
      <textarea class='textarea' v-model='review' placeholder='What you gotta say?'></textarea>
      <br />
    </div>
    
    <label class='label' for='tags'>Tags</label>
    <tag-list v-model='tags'></tag-list>
    <br />

    <button class='button is-primary tooltip is-tooltip-right' id='submitForm' disabled='' type='submit' @click='submit' data-tooltip='You need to pick a movie first'>Submit</button>
  </div>
</template>

<script>
import AutoComplete from '@/components/AutoComplete.vue'
import TagList from '@/components/TagList.vue'
import bulmaTooltip from 'bulma-tooltip'
import api from '@/mixins/api'

export default {
  name: 'movie-review',
  mixins: [api],

  components: {
    AutoComplete,
    TagList,
  },

  props: ['defMovie', 'defRating', 'defReview', 'defTags'],

  data() {
    return {
      movieList: [],
      ratings: ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D', 'F'],

      movie:  this.defMovie  || {},
      rating: this.defRating || '',
      review: this.defReview || '',
      tags:   this.defTags   || [],
    }
  },
  
  methods: {
    submit() {
      let movieData = {
        id:      this.movie.id,
        title:   this.movie.name,
        tmdb_id: this.movie.tmdb_id,
        rating:  this.rating,
        review:  this.review,
        tags:    this.tags,
      }

      this.$emit('submit', movieData)
    },

    // AutoComplete event listeners
    selectMovie(item) {
      // Update the submit button and set the selected item
      if (item && item.tmdb_id) {
        this.toggleSubmit(true)

        this.movie.tmdb_id = item.tmdb_id
        this.movie.name    = item.text
      } else {
        this.toggleSubmit()
        this.movie = { id: this.movie.id }
      }
    },

    toggleSubmit(on = false) {
      if (on) {
        document.getElementById('submitForm').disabled = false
        document.getElementById('submitForm').classList.remove('tooltip')
      } else {
        document.getElementById('submitForm').disabled = true
        document.getElementById('submitForm').classList.add('tooltip')
      }
    },

    findMovies(search, callback) {
      let params  = { title: search }

      this.get('/movies/dropdown', { auth: true, params: params })
        .then(res => this.movieList = this.parseMovies(res.data))
          .then(() => callback())
    },

    // Parses the dropdown response into the correct format for our component
    parseMovies(list) {
      return list.map(function(i) {
        return { tmdb_id: i.id, text: i.title, subtext: i.year }
      })
    },
  },

  mounted() {
    if(this.movie && this.rating) {
      this.toggleSubmit(true)
    }
  }
}
</script>

<style scoped>
  select:invalid { 
    color: #828282;
  }

  #fullReview { height: 200px; }
</style>