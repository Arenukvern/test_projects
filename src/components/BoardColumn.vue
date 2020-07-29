<template lang="pug">
.board__column
  .board__column-header(:class='classes')
  .board__column-body

</template>
<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator'
import { Colors } from '@/constants/Colors'
import { getAtomClassNameObj } from '@/functions/getAtomClassNameObj'
@Component({})
export class BoardComponent extends Vue {
  @Prop({ required: true }) readonly color: Colors
  get classes() {
    return getAtomClassNameObj([this.color])
  }
}
</script>
