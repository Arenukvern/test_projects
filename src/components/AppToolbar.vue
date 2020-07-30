<template lang="pug">
v-toolbar(:class="{'--has-text-right': true}")
  v-btn(icon @click='refresh')
    v-icon(icon='refresh')
  v-btn(icon @click='signout')
    v-icon(icon='logout')
</template>
<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'
import { StatelessComponentsRouter } from '../componentsRouter'
import { Constants } from '../constants/Constants'
import { RoutesPaths } from '../constants/RoutesPaths'
import { VuexModules } from '../store'
import { CardsModuleI } from '../store/CardsModule'
const VToolbar = StatelessComponentsRouter.VToolbar
const VIcon = StatelessComponentsRouter.VIcon
const VBtn = StatelessComponentsRouter.VBtn

@Component({
  components: {
    VToolbar,
    VIcon,
    VBtn,
  },
})
export default class AppToolbar extends Vue {
  signout() {
    localStorage.removeItem(Constants.token)
    this.$router.push(RoutesPaths.auth)
  }
  async refresh() {
    await this.$store.dispatch(
      `${VuexModules.CardsModule}/${CardsModuleI.actions.get}`
    )
  }
}
</script>
