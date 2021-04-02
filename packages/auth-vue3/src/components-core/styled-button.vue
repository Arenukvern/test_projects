<template lang="pug">
button(
  :class='resolvedClasses'
)
  slot
</template>

<script lang="ts">
  import { computed, defineComponent } from 'vue'
  const theme = {
    light: `
      hover-back-coffee-bean-2
      focus-back-coffee-bean-5
    `,
    dark: `
      flat-coffee-bean
    `,
  }
  const coreClasses = `
    button
    
    w-full 

    transition-duration-04
    transition-all
    transition-easy
    
    focus-shadow-26-coffee-bean-10
  `
  export default defineComponent({
    name: 'styled-button',
    props: {
      hasIcon: {
        type: Boolean,
        default: false,
        required: false,
      },
      scaleOnHover: {
        type: Boolean,
        default: false,
        required: false,
      },
      isDark: {
        type: Boolean,
        default: false,
        required: false,
      },
    },
    setup(props) {
      const resolvedClasses = computed(() => {
        const resolvedIconClass = props.hasIcon ? 'icon' : ''
        const resolvedScaleOnHoverClass = props.scaleOnHover
          ? 'hover-scale-12'
          : ''
        const resolvedIsDark = props.isDark ? theme.dark : theme.light
        return [
          coreClasses,
          resolvedIconClass,
          resolvedScaleOnHoverClass,
          resolvedIsDark,
        ].join(' ')
      })

      return { resolvedClasses }
    },
  })
</script>

<style></style>
