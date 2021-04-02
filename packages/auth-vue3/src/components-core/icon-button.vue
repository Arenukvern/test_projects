<template lang="pug">
styled-button(
  :has-icon='true'
  :scale-on-hover='true'
)
  slot
</template>

<script lang="ts">
  import { defineAsyncComponent, defineComponent } from 'vue'
  export default defineComponent({
    name: 'icon-button',
    components: {
      StyledButton: defineAsyncComponent(() => import('./styled-button.vue')),
    },
  })
</script>

<style></style>
