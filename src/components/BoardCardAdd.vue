<template lang="pug">
.board__card(v-if='isOpened' :class="{'--is-open': isOpened}")
  .board__card-body
    v-input(:textarea='true' v-model='card.text' placeholder='Ввести заголовок для этой карточки')
  .board__card-actions
    v-btn(:class="{'--is-light':true}" :small='true' @click='create') Добавить карточку
    v-btn(:class="{'--is-icon':true,'--is-light':true}" :small='true' @click='close')
      v-icon(icon='close' :small='true')
.board__card-creator(v-else @click.prevent='open')
  span.p-05.--has-text-sm +
  span.p-05.--has-text-sm.--has-text-left Добавить карточку
</template>
<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator'
import { StatelessComponentsRouter } from '../componentsRouter'
import { Card } from '../entities/Card'
import { CardService } from '../services/CardService'
import { VuexModules } from '../store'
import { CardsModuleI } from '../store/CardsModule'
const VBtn = StatelessComponentsRouter.VBtn
const VIcon = StatelessComponentsRouter.VIcon
const VInput = StatelessComponentsRouter.VInput
@Component({
  components: {
    VBtn,
    VIcon,
    VInput,
  },
})
export default class BoardCardAddComponent extends Vue {
  isOpened: boolean = false
  card: Card = new Card()
  @Prop({ required: true }) readonly row: string
  mounted() {
    this.card.row = this.row
  }
  close() {
    this.isOpened = false
  }
  open() {
    this.isOpened = true
  }
  async create() {
    const service = new CardService()
    if (this.card.text.length <= 0) {
      this.close()
      return
    }
    const resp = await service.create({ row: this.row, text: this.card.text })
    if (resp.ok) {
      this.$store.commit(
        `${VuexModules.CardsModule}/${CardsModuleI.mutations.save}`,
        await resp.json()
      )
      this.close()
      this.card = new Card()
      this.card.row = this.row
    }
  }
}
</script>
