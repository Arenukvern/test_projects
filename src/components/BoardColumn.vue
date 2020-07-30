<template lang="pug">
.board__column(:key='name')
  .board__column-header.--has-text-centered.--has-text-accent.--has-text-shadow(:class='classes') {{name}} ({{cardsCount}})
  .board__column-body
    draggable(
      v-model="cards" 
      draggable='.board__card' 
      @change='sort'
      v-bind="dragOptions"
      class='board__column-dropzone'
    )
      board-card(v-for="card in cards" :key='card.id' :card='card')
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
import { VuexModules } from '../store'
import { CardsModuleI } from '../store/CardsModule'
import { CardService } from '../services/CardService'
const VIcon = StatelessComponentsRouter.VIcon
const BoardCardAdd = ComponentsRouter.BoardCardAdd
const BoardCard = ComponentsRouter.BoardCard
@Component({ components: { VIcon, draggable, BoardCardAdd, BoardCard } })
export default class BoardColumnComponent extends Vue {
  drag: boolean = false
  @Prop({ required: true }) readonly column: BoardColumn
  get classes() {
    return getAtomClassNameObj([this.column.color])
  }
  get cards() {
    return this.$store.getters[
      `${VuexModules.CardsModule}/${CardsModuleI.getters.cards}`
    ][this.column.id]
  }
  set cards(cards: Card[]) {
    this.$store.commit(
      `${VuexModules.CardsModule}/${CardsModuleI.mutations.saveAll}`,
      { row: this.column.id, cards }
    )
  }
  get name() {
    return this.column.name.toUpperCase()
  }
  async sort() {
    const newCards = []
    const cardService = new CardService()
    for (const [i, card] of this.cards.entries()) {
      const resp = await cardService.update(
        { row: this.column.id, seq_num: i, text: card.text },
        card.id
      )
      if (resp.ok) {
        newCards.push(await resp.json())
      }
    }
    this.cards = newCards
  }
  get cardsCount() {
    return this.cards.length
  }
  dragOptions = {
    animation: 200,
    group: 'cards',
    disabled: false,
    ghostClass: '--is-chosen',
    chosenClass: '--is-chosen',
  }
}
</script>
