<template lang="pug">
.board__column
  .board__column-header.--has-text-centered(:class='classes') {{name}}
    v-icon(icon='delete')
  .board__column-body

</template>
<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator'
import { Colors } from '@/constants/Colors'
import { getAtomClassNameObj } from '@/functions/getAtomClassNameObj'
import { StatelessComponentsRouter } from '../componentsRouter'
const VIcon = StatelessComponentsRouter.VIcon
@Component({ components: { VIcon } })
export default class BoardComponent extends Vue {
  @Prop({ required: true }) readonly color: Colors
  get classes() {
    return getAtomClassNameObj([this.color])
  }
  @Prop({ required: true }) readonly name: string
}
</script>
