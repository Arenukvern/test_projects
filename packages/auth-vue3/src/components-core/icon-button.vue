<template lang="pug">
styled-button(
  :has-icon='true'
  :scale-on-hover='true'
  @click='click'
)
  slot
</template>

<script lang="ts">
  import { defineAsyncComponent, defineComponent } from 'vue'
  import { styledButtonEmits, styledButtonClick } from './styled-button-i'
  export default defineComponent({
    name: 'icon-button',
    components: {
      StyledButton: defineAsyncComponent(() => import('./styled-button.vue')),
    },
    emits: styledButtonEmits,
    setup(_props, context) {
      return { click: styledButtonClick({ context }) }
    },
  })
</script>

<style></style>
