<template lang="pug">
.board__card
  .board__card-header
    .board__card-header.--has-accent id:
    div {{card.id}}
    .board__card-delete
      v-btn(@click='deleteCard' :small='true' :class="{'--is-light': true, '--is-icon': true, }")
        v-icon(icon='close')
  .board__card-body {{card.text}}
</template>
<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator'
import { Card } from '../entities/Card'
import { StatelessComponentsRouter } from '../componentsRouter'
import { VuexModules } from '../store'
import { CardsModuleI } from '../store/CardsModule'
import { CardService } from '../services/CardService'
const VBtn = StatelessComponentsRouter.VBtn
const VIcon = StatelessComponentsRouter.VIcon

@Component({ components: { VBtn, VIcon } })
export default class BoardCardComponent extends Vue {
  @Prop({ required: true }) readonly card: Card
  async deleteCard() {
    const cardService = new CardService()
    await cardService.delete(this.card.id)
    this.$store.commit(
      `${VuexModules.CardsModule}/${CardsModuleI.mutations.delete}`,
      this.card
    )
  }
}
</script>
