<template lang="pug">
.board__card(v-if='isOpened')
  .board__card-header
    .board__card-header.--has-accent id:
    div {{id}}
    v-btn()
      v-icon(icon='close')
  .board__card-body

    .row
      span.p 
        v-btn Добавить карточку
      span.p 
        v-btn
          v-icon(icon='close')
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
  isOpened: boolean = false
}
</script>
