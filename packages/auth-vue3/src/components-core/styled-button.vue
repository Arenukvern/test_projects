<template lang="pug">
button(
  :class='resolvedClasses'
  @click='click'
)
  slot
</template>

<script lang="ts">
  import { computed, defineComponent } from 'vue'
  import { styledButtonClick, styledButtonEmits } from './styled-button-i'
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
    row
    
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
      mainAlignClass: {
        type: String,
        default: 'center',
        required: false,
      },
    },
    emits: styledButtonEmits,
    setup(props, context) {
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
          props.mainAlignClass,
        ].join(' ')
      })

      return { resolvedClasses, click: styledButtonClick({ context }) }
    },
  })
</script>

<style></style>
