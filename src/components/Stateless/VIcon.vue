<template lang="pug">
.icon(@click.prevent='$emit('click')' :class='classes')
</template>
<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator'
import { getAtomClassNameObj } from '../../functions/getAtomClassNameObj'
import { ComponentSizes } from '@/constants/ComponentSizes'
import { mixins } from 'vue-class-component'
import SizeMixin from './SizeMixin'

@Component({})
export class VIcon extends mixins(SizeMixin) {
  @Prop({ required: true }) readonly icon: string
  get classes() {
    return getAtomClassNameObj([this.size])
  }
}
</script>
