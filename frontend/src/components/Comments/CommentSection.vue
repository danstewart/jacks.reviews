<template>
  <div class='comment-section'>
    <div class='column'>
      <div class='comment' v-for='(comment, index) in comments' :key='comment.id' :class='[ index % 2 == 0 ? "comment-odd" : "comment-even"]'>
        <div class='card-content'>
          <p class='comment-text'>{{ comment.text }}</p>
          <a @click='replyTo = comment.id'>Reply</a>
        </div>
        <comment-input :replyTo='comment.id' @addComment='addComment' @cancelReply='replyTo = -1' v-if='replyTo == comment.id'/>
      </div>

      <comment-input @addComment='addComment' v-if='replyTo == -1'/>
    </div>
  </div>
</template>

<script>
import CommentInput from '@/components/Comments/CommentInput.vue'

export default {
  name: 'CommentSection',

  components: {
    CommentInput,
  },

  props: {
    comments: {
      type: Array,
      required: true,
    },
    movieId: {
      type: Number,
      required: true,
    }
  },

  data() {
    return {
      replyTo: -1,
    }
  },

  methods: {
    addComment(comment, replyTo = null) {
      // TODO:
      let commentCount = this.comments.push({ text: comment })
      this.$parent.expand(this.movieId, false)

      // TODO: POST comment
      let newCommentId = commentCount // Get ID from POST response
      this.comments[commentCount - 1].id = newCommentId
    },
  },
}
</script>

<style scoped>
  .comment-odd {
    background-color: #3d4343;
  }

  .comment-even {
    background-color: #242a2a;
  }

  .comment-text {
    padding-bottom: 10px;
  }

  .reply {
    pointer-events: none;
  }
</style>
