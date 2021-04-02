<template lang="pug">
img.absolute.b-0.l-0.z-0(src='./assets/tree.svg' alt="a tree" )
.grid.columns-1.rows-90p.h-full.relative.z-10
  .column.center
    .column.main-align-space-between.h-6
      p.text.center.h4 Welcome back
      .row.cross-align-center
        input(
            type='text'
            class=`            
            h-2
            hover-back-coffee-bean-2

            focus-back-coffee-bean-5
            focus-shadow-26-coffee-bean-4

            border-radius-5
            border-bottom-1
            border-bottom-dashed
            border-bottom-color-seashell

            pl-4
            pr-4

            back-color-seashell
            
            transition-duration-04
            transition-all
            transition-easy
            `
            placeholder='email'
          )
        button(
          class=`
            ml-4

            button
            icon
            
            transition-duration-04
            transition-all
            transition-easy
            
            hover-scale-12
            hover-back-coffee-bean-2
            focus-back-coffee-bean-5
            focus-shadow-26-coffee-bean-10

          `
        )
          img(src='./assets/send.svg')
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
