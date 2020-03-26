<template>
  <div class='tag-list'>
    <div class='columns'>
      <div class='column'>
        <div class='field has-addons'>
          <div class='control is-expanded'>
            <input class='input' v-model='tag' @keyup.enter='addTag()' placeholder='Action, Funny, Must See...'/>
          </div>
          <div class='control'>
            <!-- TODO: Replace &nbsp with CSS -->
            <a class='button is-primary' @click='addTag()'>&nbsp;&nbsp;Add&nbsp;&nbsp;&nbsp;</a>
          </div>
         </div>
      </div>
      <div class='column'>
        <button class='button is-primary tag-item is-rounded' v-for='(item, i) in results' :key='i' @click='removeTag(i)'>
          {{ item }}
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'TagList',

  model: {
    prop: 'list',
    event: 'change'
  },

  props: {
    list: {
      type: Array,
      required: false,
    }
  },

  data() {
    return {
      tag: '',
      results: this.list || [],
    }
  },

  methods: {
    addTag() {
      if (!this.tag) return

      // Titlecase the tag and remove whitespace
      this.tag = this.tag.split(' ').map(i => i[0].toUpperCase() + i.slice(1)).join(' ')
      this.tag = this.tag.replace(/\s+/g, '')

      // Add the tag to the list and reset the input field
      this.results.push(this.tag)
      this.tag = ''

      this.$emit('change', this.results)
    },

    removeTag(i) {
      this.results.splice(i, 1)
      this.$emit('change', this.results)
    }
  },
}
</script>

<style scoped>
.tag-item {
  margin-right:  5px;
  margin-bottom: 5px;
}
</style>