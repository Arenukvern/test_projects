<template lang="pug">
.board
  board-column-component(v-for='(column,i) in columns' :key='i' :column='column')
</template>
<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'
import { ComponentsRouter } from '../componentsRouter'
import { BoardColumn } from '../entities/BoardColumn'
import { BoardColumns } from '../constants/BoardColumns'
import { Colors } from '../constants/Colors'
import { VuexModules } from '../store'
import { CardsModuleI } from '../store/CardsModule'
const BoardColumnComponent = ComponentsRouter.BoardColumn
const BoardCard = ComponentsRouter.BoardCard

@Component({
  components: {
    BoardColumnComponent,
    BoardCard,
  },
})
export default class BoardComponent extends Vue {
  columns: BoardColumn[] = [
    new BoardColumn(BoardColumns[0], Colors.orange, 'On hold'),
    new BoardColumn(BoardColumns[1], Colors.blue, 'In progress'),
    new BoardColumn(BoardColumns[2], Colors.yellow, 'Needs review'),
    new BoardColumn(BoardColumns[3], Colors.green, 'Approved'),
  ]
  async mounted() {
    await this.$store.dispatch(
      `${VuexModules.CardsModule}/${CardsModuleI.actions.get}`
    )
  }
}
</script>
