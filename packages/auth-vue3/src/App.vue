<template lang="pug">
img.absolute.b-0.l-0.z-0(src='./assets/tree.svg' alt="a tree" )
.column.relative.z-10
  .column.align-center
    div Welcome
    .row
      input(type='text')
      button(alt='send')
  .row
    button Sign in
    button Sign up
</template>

<script lang="ts">
  import { defineComponent } from 'vue'
  import HelloWorld from './components/HelloWorld.vue'

  export default defineComponent({
    name: 'App',
    components: {
      HelloWorld,
    },
  })
</script>

<style></style>
