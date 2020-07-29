<template lang="pug">
.btn(@click.prevent="$emit('click')" :class='classes') 
  slot
</template>
<script lang="ts">
import { Component } from 'vue-property-decorator'
import { getAtomClassNameObj } from '../../functions/getAtomClassNameObj'
import { mixins } from 'vue-class-component'
import SizeMixin from './SizeMixin'
@Component({})
export default class VBtn extends mixins(SizeMixin) {
  get classes() {
    return getAtomClassNameObj([this.size])
  }
}
</script>
