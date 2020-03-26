<template>
  <div class='auto-complete control'>
    <div class='field has-addons'>
      <span class='control is-expanded'>
        <input 
          id='input'
          type='text' 
          class='input' 
          v-model='search'
          @input='onChange'
          @focus='onFocus'
          @keyup.down='onArrowDown'
          @keyup.up='onArrowUp'
          @keyup.enter='onEnter'
          placeholder='Type in your search then press enter'
        />
      </span>
      <span class='control' >
        <button class='button is-primary' v-bind:class="{ 'is-loading': loading }" @click='onEnter'>Search</button>
      </span>
    </div>
    <table v-if='isOpen' width='100%'>
      <tbody>
        <tr 
          v-for='(item, i) in results' 
          :key='i'
          :class="{ 'is-active': i === arrowCounter }"
          @click='setResult(item)'
        >
          <td>{{ item.text}} <span class='subtext'>{{ item.subtext }}</span></td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: 'AutoComplete',

  // Handles v-model usage for component
  model: {
    prop: 'value',
    event: 'setResult'
  },

  props: {
    value: {
      type: Object,
      required: false,
    },
    source: {
      type: String,
      required: true,
    },
    list: {
      type: Array,
      required: true,
    },
  },

  data() {
    return {
      search: this.value.name || '',
      results: this.list,
      isOpen: false,
      arrowCounter: -1,
      loading: false,
    }
  },

  updated()   { this.$emit('input', this.input) },
  mounted()   { document.addEventListener('click', this.onClickOutside) },
  destroyed() { document.removeEventListener('click', this.onClickOutside) },

  methods: {
    // Dropdown functions
    onFocus() {
      if (this.search.length > 0) 
        this.isOpen = true;
    },
    onChange() {
      this.setResult(null); // Unset the selected item
      this.isOpen = true;
      this.filterResults();
      this.loading = false;
    },
    filterResults() {
      if (this.search.length === 0) {
        // Search input is empty, reset dropdown
        this.isOpen = false;
        this.arrowCounter = -1;

      } else {
        // Filter results to match our search input
        // TODO: This should be improved to have better matching
        this.results = this.list.filter(
          item => item.text.toLowerCase().indexOf(this.search.toLowerCase()) > -1
        );
      }
    },
    setResult(result) {
      // If we have a result then update the input, close the dropdown & reset our arrow index
      if (result) {
        this.search       = result.text;
        this.isOpen       = false;
        this.arrowCounter = -1;
      }

      // Let the parent handle the selection
      this.$emit('selectItem', result);
    },

    // Keys and clicks
    onClickOutside(evt) {
      if (!this.$el.contains(evt.target)) {
        this.isOpen = false;
        this.arrowCounter = -1;
      }
    },
    onArrowDown() {
      if (this.arrowCounter < this.results.length - 1)
        this.arrowCounter++;
    },
    onArrowUp() {
      if (this.arrowCounter > 0)
        this.arrowCounter--;
    },
    onEnter() {
      if (this.search === '') return

      // If using the arrow keys then select the item
      // otherwise populate the dropdown
      if (this.isOpen && this.arrowCounter > -1) {
        this.setResult(this.results[this.arrowCounter]);
        return;
      }

      // Emit search even to parent then trigger our onChange event
      this.loading = true
      this.$emit('getResults', this.search, this.onChange);
    },
  }
}
</script>

<style scoped>
auto-complete table {
  position: absolute;
  width: 50%;
  box-shadow: 0px 0px 20px rgba(0, 0, 0, 0.1);
  border-radius: 3px;
  border: 2px solid #888;
  border-top: 0px;
  cursor: pointer;
  z-index: 99999 !important; 
}

.auto-complete table tr {
  background: white;
  position: relative;
}

.auto-complete table tr td {
  padding: 10px
}

.auto-complete table tr:nth-child(even) {
  background: #e5e5e5;
}

.auto-complete table tr.is-active,
.auto-complete table tr:hover {
  background: #4484CE;
  color: white;
}

.subtext {
  font-size: 0.7em;
  color: #717171;
}

</style>
