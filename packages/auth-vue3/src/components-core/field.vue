<template lang="pug">
input(
  :type='"text"'
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
  :placeholder='placeholder'
)
</template>

<script lang="ts">
  import { defineComponent } from 'vue'
  export default defineComponent({
    name: 'field',
    props: {
      placeholder: {
        type: String,
        default: '',
        required: false,
      },
    },
  })
</script>
