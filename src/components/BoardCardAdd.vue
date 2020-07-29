<template lang="pug">
.board__card(v-if='isOpened' :class="{'--is-open': isOpened}")
  .board__card-body
    v-input(:textarea='true' v-model='card.text' placeholder='Ввести заголовок для этой карточки')
  .board__card-actions
    v-btn(:class="{'--is-light':true}" :small='true') Добавить карточку
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
  isOpened: boolean = true
  card: Card = new Card()
  close() {
    this.isOpened = false
  }
  open() {
    this.isOpened = true
  }
}
</script>
