<template lang="pug">
.column
  app-toolbar
  board
</template>

<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'
import { ComponentsRouter } from '../componentsRouter'

const Board = ComponentsRouter.Board
const AppToolbar = ComponentsRouter.AppToolbar
@Component({
  components: {
    Board,
    AppToolbar,
  },
})
export default class HomeView extends Vue {}
</script>
