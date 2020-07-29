<template lang="pug">
.field
  label.field__input(:for='uuid') {{label}}
    input(v-model='pInput' :id='uuid' v-if='!textarea' :placeholder='placeholder') 
    textarea(v-model='pInput' :id='uuid' v-if='textarea' :placeholder='placeholder' rows= '4' :maxlength='maxlength') 
  .field__input-errors {{error}}
</template>
<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator'
import { v4 as uuidv4 } from 'uuid'

@Component({})
export default class VInput extends Vue {
  @Prop({ required: false, default: false }) readonly textarea: boolean
  @Prop({ required: false, default: 500 }) readonly maxlength: number
  @Prop({ required: false, default: '' }) readonly placeholder: string

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
  @Prop({ required: false, default: '' }) readonly label: string
}
</script>
