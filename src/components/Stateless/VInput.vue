<template lang="pug">
.input
  input(v-model='pInput') 
  .input__errors {{error}}
</template>
<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
@Component({})
export default class VInput extends Vue {
  @Prop({ required: true }) readonly value: string
  set pInput(value: string) {
    this.$emit('input', value)
  }
  get pInput() {
    return this.value
  }
  @Prop({ required: false, default: '' }) readonly errors: string | string[]
  get error() {
    return Array.isArray(this.errors) ? this.errors[0] : this.errors
  }
}
</script>
