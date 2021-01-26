<template>
  <div class='home'>
    <!-- NOTE: v-bind is used here instead of v-model since v-model behaves funny with android -->
    <!--       See https://github.com/vuejs/vue/issues/8723 -->
    <div class='column'>
      <input class='input' placeholder='Search' :bind='search' @input='updateSearch'/>

      <div v-if='this.loaded && filteredMovies.length == 0'>
        <br>
        <p class='subtitle'>No results found</p>
      </div>
    </div>

    <div v-if='!this.loaded' class='loader'></div>

    <ul class='movie-grid'>
      <li ref='movie' class='slide' v-for='(movie, index) in filteredMovies' :key='index'>
        <img class='poster' :src='movie.image' @click='toggleMovie(index)'>

        <div ref='expanded' class='detail slide' v-if='expanded == index'>
          <div class='card'>
            <div class='card-header'>
              <p class='card-header-title'>{{ movie.title }}</p>
              <p class='card-header-icon'>{{ movie.rating }}</p>
            </div>
            <div class='card-content'>
              <div class='media-content'>
                <span class='review'>{{ movie.review || 'No review yet...' }}</span>
              </div>
            </div>

            <!-- TODO: Implement tag view -->
            <div class='card-content'>
              <div v-if='movie.tags.length' style='float:left'>
                <a href='#' v-for='(tag, index) in movie.tags' :key='index'>#{{ tag }} </a>
              </div>

              <!-- TODO: Support comments -->
              <!-- <div style='float: right'> -->
                <!-- <a @click='toggleComments(index)'>{{ commentCount(movie) }}</a> -->
              <!-- </div> -->
              <br/>
            </div>

            <!-- TODO: Support comments -->
            <!-- <div ref='comments' v-if='showComments' > -->
              <!-- <comment-section :movieId='index' :comments='movie.comments'></comment-section> -->
            <!-- </div> -->

            <div class='card-footer' v-if='loggedIn'>
              <a class='card-footer-item' :href='`/#/edit/${movie.id}`'>Edit</a>
              <a class='card-footer-item card-footer-item-last' @click='showModal()'>Delete</a>

              <confirm-delete
                ref='delete'
                @delete='deleteMovie'
                :id='movie.id'
                :index='index'
                :text='deleteMsg(movie.title)'>
              </confirm-delete>
            </div>

            <!-- HACK: Empty div to use for getting bottom of details -->
            <div ref='cardBottom'></div>
          </div>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import api from '@/mixins/api'
import sizes from '@/mixins/sizes'
import nativeToast  from 'native-toast';
import CommentSection from '@/components/Comments/CommentSection.vue'
import ConfirmDelete from '@/components/modals/ConfirmDelete.vue'

export default {
  name: 'home',
  mixins: [api, sizes],

  components: {
    ConfirmDelete,
    CommentSection,
  },
  
  props: {
    loggedIn: {
      type: Boolean,
      required: true,
    }
  },

  data() {
    return {
        movies: [],
        search: '',
        expanded: -1,
        loaded: false,
        showComments: false,
    }
  },

  computed: {
    filteredMovies: function() {
      let list = this.movies

      if (this.search) {
        list = this.movies.filter(
          item => item.title.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        );
      }

      return list
    }
  },

  methods: {
    updateSearch(e) {
      // Collapse any expanded movies
      if (this.expanded > -1) {
        this.collapse(this.expanded)
        this.expanded = -1
      }

      this.search = e.target.value
    },

    toggleComments(movieId) {
      // Show the comments, wait for DOM to update then
      // expand the details to fit the comments
      this.showComments = !this.showComments

      this.$nextTick(function () {
        this.expand(movieId, false)
      })
    },

    async toggleMovie(movieId) {
      this.showComments = false

      if (this.expanded > -1) {
        // Collapse the current open movie
        await this.collapse(this.expanded)

        // If we are just collapsing then bail out
        if (this.expanded == movieId) {
          this.expanded = -1
          return
        }
      }

      this.expand(movieId)
    },

    async expand(movieId, scroll = true) {
      this.expanded = movieId

      // Wait for DOM to update then expand the movie height
      // to show the review 
      this.$nextTick(function () {
        let cardHeight = 350
        let height = this.$refs.cardBottom[0].offsetTop
        this.$refs.expanded[0].style.height = `${height}px`
        this.$refs.movie[this.expanded].style.height = `${height + cardHeight}px`
      })

      if (!scroll) return

      // Sleep to let animation finish then scroll down
      await new Promise(resolve => setTimeout(resolve, 150))

      // Scroll the review into view
      let moviePosition = this.$refs.movie[this.expanded].offsetTop
      window.scroll({
        top: moviePosition,
        left: 0,
        behavior: 'smooth'
      })
    },

    async collapse(movieId) {
      let posterHeight = 330;
      this.$refs.expanded[0].style.height = '0px'
      this.$refs.movie[movieId].style.height = `${posterHeight}px`

      // Sleep to let collapse animation finish before opening a new one
      await new Promise(resolve => setTimeout(resolve, 250))
    },

    showModal() {
      this.$refs.delete[0].toggle()
    },

    deleteMovie(index, id) {
      this.delete(`/movies/${id}`, { auth: true })
        .then(() => {
          nativeToast({
            message: 'Successfully deleted review',
            position: 'top',
            timeout: 2500,
            type: 'success',
            closeOnClick: true,
          });

          this.movies.splice(index, 1)
        })

      // Close details
      this.expand(index, index)
    },

    deleteMsg(title) {
      return `Delete review for "${title}"?`
    },

    commentCount(movie) {
      let totalComments = movie.comments.length
      return totalComments == 1 ? '1 Comment' : `${totalComments} Comments`
    }
  },

  async created() {
    try {
      let movies = await this.get('/movies')
      this.movies = movies.data
    } finally {
      this.loaded = true
    }
  },
}
</script>

<style scoped>
  .input {
    margin-bottom: 10px;
  }

  .review {
    white-space: pre-line;
  }

  .poster {
    width: 220px;
    height: 330px;
  }

  .movie-grid {
    list-style: none;
    padding: 20px 0;
    margin-top: 0 auto;
    text-align: center;
    width: 100%;
  }

  .movie-grid * {
    text-align: left;
  }

  .movie-grid li {
    display: inline-block;
    margin: 10px 5px 0 5px;
    height: 330px;
    vertical-align: top;
  }

  /* Card borders */
  .card { border: none; }
  .card-footer { border: none; }
  .card-footer-item { border: none; }
  .card-footer-item-last { border-left: 2px solid #282f2f; }

  .detail {
    border: 2px solid #282f2f;
    position: absolute;
    margin-left: 1px;
    margin-right: 1px;
    top: auto;
    left: 0;
    right: 0;
  }

  .slide {
    overflow: hidden;
    height: 0px;
    
    transition:           height 350ms ease;
      -moz-transition:    height 350ms ease;
      -ms-transition:     height 350ms ease;
      -o-transition:      height 350ms ease;
      -webkit-transition: height 350ms ease;
  }

  .loader {
    margin: 0 auto;
    height: 50px;
    width: 50px;
  }
</style>
