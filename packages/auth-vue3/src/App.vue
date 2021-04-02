<template lang="pug">
img.absolute.b-0.l-0.z-0(src='./assets/tree.svg' alt="a tree" )
.grid.columns-1.rows-90p.h-full.relative.z-10
  .column.center
    .column.main-align-space-between.h-6
      p.text.center.h4 Welcome back
      .row.cross-align-center
        field.mr-4(placeholder='email')
        icon-button()
          img(src='./assets/send.svg')
  .row.cross-align-end
    styled-button.border-top-right-corner-80(:isDark='true') Sign in
    styled-button Sign up
</template>

<script lang="ts">
  import { defineAsyncComponent, defineComponent } from 'vue'

  export default defineComponent({
    name: 'App',
    components: {
      Field: defineAsyncComponent(() => import('./components-core/field.vue')),
      IconButton: defineAsyncComponent(
        () => import('./components-core/icon-button.vue')
      ),
      StyledButton: defineAsyncComponent(
        () => import('./components-core/styled-button.vue')
      ),
    },
  })
</script>

<style></style>
