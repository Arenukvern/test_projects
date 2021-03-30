<template lang="pug">
.btn(@click.prevent="$emit('click')" :class='classes') 
  slot
</template>
<script lang="ts">
import { Component, Prop } from 'vue-property-decorator'
import { getAtomClassNameObj } from '../../functions/getAtomClassNameObj'
import { mixins } from 'vue-class-component'
import SizeMixin from './SizeMixin'
@Component({})
export default class VBtn extends mixins(SizeMixin) {
  @Prop({ required: false, default: false }) readonly icon: boolean
  get classes() {
    return getAtomClassNameObj([this.size, this.icon ? 'icon' : ''])
  }
}
</script>
