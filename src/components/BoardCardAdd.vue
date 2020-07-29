<template lang="pug">
.board__card(v-if='isOpened' :class="{'--is-open': isOpened}")
  .board__card-body

  .board__card-actions
    v-btn(:class="{'--is-light':true}" :small='true') Добавить карточку
    v-btn(:class="{'--is-icon':true,'--is-light':true}" :small='true')
      v-icon(icon='close' :small='true')
.board__card-creator(v-else)
  span.p-05.--has-text-sm +
  span.p-05.--has-text-sm.--has-text-left Добавить карточку
</template>
<script lang="ts">
import { Vue, Component, Prop } from 'vue-property-decorator'
import { StatelessComponentsRouter } from '../componentsRouter'
const VBtn = StatelessComponentsRouter.VBtn
const VIcon = StatelessComponentsRouter.VIcon

@Component({
  components: {
    VBtn,
    VIcon,
  },
})
export default class BoardCardAddComponent extends Vue {
  isOpened: boolean = true
}
</script>
