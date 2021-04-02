<template lang="pug">
.app.back-color-seashell.color-coffee-bean
  img.absolute.b-0.l-0.z-0(:src='"./assets/tree.svg"' alt="a tree" )
  auth
</template>

<script lang="ts">
  import { defineAsyncComponent, defineComponent } from 'vue'

  export default defineComponent({
    name: 'App',
    components: {
      Auth: defineAsyncComponent(() => import('./components/auth/auth.vue')),
    },
  })
</script>

<style></style>
