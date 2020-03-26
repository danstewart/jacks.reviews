<template>
  <div class='comment-input'>
    <div class='field has-addons'>
      <div class='control' v-if='replyTo >= 0'>
        <button class='button reply' @click='$emit("cancelReply")'></button>
      </div>
      <div class='control is-expanded'>
        <input class='input' v-model='newComment' placeholder='Comment' />
      </div>
      <div class='control'>
        <a class='button is-primary' @click='addComment'>Add</a>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'CommentInput',

  props: {
    replyTo: {
      type: Number,
      required: false,
    }
  },

  data() {
    return {
      newComment: '',
    }
  },

  methods: {
    addComment() {
      if (this.newComment) {
        this.$emit('addComment', this.newComment, this.replyTo);
        this.newComment = ''
      }
    },
  },
}
</script>

<style scoped>
  .reply:hover:after {
    width: 50px;
    content: "\f057";
    font-family: "Font Awesome 5 Free";
  }
  .reply:after {
    width: 50px;
    content: "Reply";
  }

  .reply {
    border-width: 0px;
    border-style: none;
    z-index: 0;
    position: static;
  }

  .reply:hover {
    border-width: 0px;
    border-style: none;
    z-index: 0;
    position: static;
  }
</style>
