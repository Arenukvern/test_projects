<template lang="pug">
.icon(@click.prevent="$emit('click')" :class='classes')
  i.material-icons(:class='iClasses') {{icon}}
</template>
<script lang="ts">
import { Component, Prop } from 'vue-property-decorator'
import { getAtomClassNameObj } from '../../functions/getAtomClassNameObj'
import { mixins } from 'vue-class-component'
import SizeMixin from './SizeMixin'
@Component({})
export default class VIcon extends mixins(SizeMixin) {
  @Prop({ required: true }) readonly icon: string
  get iClasses() {
    const obj: { [cls: string]: boolean } = {}
    if (this.small) {
      obj['md-18'] = true
    }
    return obj
  }
  get classes() {
    return getAtomClassNameObj([this.size])
  }
}
</script>
