<template lang="pug">
label.input(:for='uiid')
  {{label}}
  input(v-model='pInput' :id='uuid') 
  .input__errors {{error}}
</template>
<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import { v4 as uuidv4 } from 'uuid'

@Component({})
export default class VInput extends Vue {
  mounted() {
    this.uuid = uuidv4()
  }
  uuid: string = ''
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
  @Prop({ required: true }) readonly label: string
}
</script>
