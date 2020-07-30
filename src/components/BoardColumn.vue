<template lang="pug">
.board__column(:key='name')
  .board__column-header.--has-text-centered.--has-text-accent(:class='classes') {{name}}
  .board__column-body
    draggable(v-model="cards" group="cards")
    board-card-add(:row='column.id')
</template>
<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator'
import { getAtomClassNameObj } from '@/functions/getAtomClassNameObj'
import {
  StatelessComponentsRouter,
  ComponentsRouter,
} from '../componentsRouter'
import draggable from 'vuedraggable'
import { Card } from '../entities/Card'
import { BoardColumn } from '@/entities/BoardColumn'
const VIcon = StatelessComponentsRouter.VIcon
const BoardCardAdd = ComponentsRouter.BoardCardAdd
@Component({ components: { VIcon, draggable, BoardCardAdd } })
export default class BoardColumnComponent extends Vue {
  @Prop({ required: true }) readonly column: BoardColumn
  get classes() {
    return getAtomClassNameObj([this.column.color])
  }
  cards: Card[] = []
  get name() {
    return this.column.name.toUpperCase()
  }
}
</script>
