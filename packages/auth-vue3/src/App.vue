<template lang="pug">
img.absolute.b-0.l-0.z-0(src='./assets/tree.svg' alt="a tree" )
.grid.columns-1.rows-90p.h-full.relative.z-10
  .column.center
    .column.main-align-space-between.h-6
      p.text.center.h4 Welcome back
      .row
        input(type='text')
        button.button(alt='send')
  .row.cross-align-end
    button.button.w-full Sign in
    button.button.w-full Sign up
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
