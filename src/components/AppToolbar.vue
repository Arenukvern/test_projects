<template lang="pug">
v-toolbar
  v-icon(icon='logout')
</template>
<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'
import { StatelessComponentsRouter } from '../componentsRouter'
const VToolbar = StatelessComponentsRouter.VToolbar
const VIcon = StatelessComponentsRouter.VIcon

@Component({
  components: {
    VToolbar,
    VIcon,
  },
})
export default class AppToolbar extends Vue {}
</script>
