<template>
  <div id='confirm-delete'>
    <div id='delete' class='modal' v-bind:class='{ "is-active": visible }'>
      <div class='modal-background'></div>
      <div class='modal-card'>
        <header class='modal-card-head'>
          <p class='modal-card-title'>{{ text }}</p>
          <button @click='toggle()' class='delete'></button>
        </header>
        <footer class='modal-card-foot'>
          <button @click='deleteItem(index, id)' class='button is-danger'>Delete</button>
          <button @click='toggle()' class='button'>No, keep it</button>
        </footer>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ConfirmDelete',

  data() {
    return {
      visible: false,
    }
  },

  props: {
    id: {
      type: Number,
      required: true,
    },
    index: {
      type: Number,
      required: true,
    },
    text: {
      type: String,
      required: true,
    }
  },

  methods: {
    toggle() {
      this.visible = !this.visible
    },

    deleteItem(index, id) {
      this.visible = false
      this.$emit('delete', index, id)
    }
  }
}
</script>

<style scoped>
.modal-card-title {
  word-wrap: break-word;
  overflow-wrap: break-word;
  flex-shrink: 1;
}
</style>