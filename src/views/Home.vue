<template lang="pug">
div
  v-toolbar
    v-icon
  board
</template>

<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'
import {
  ComponentsRouter,
  StatelessComponentsRouter,
} from '../componentsRouter'
const Board = ComponentsRouter.Board
const VToolbar = StatelessComponentsRouter.VToolbar
@Component({
  components: {
    Board,
    VToolbar,
  },
})
export class HomeView extends Vue {}
</script>
