<template lang="pug">
styled-button.h5(
  @click='click'
  :class='classes'
  :isDark='isActive'
)
  slot
</template>

<script lang="ts">
  import { computed, defineAsyncComponent, defineComponent } from 'vue'
  import { styledButtonEmits, styledButtonClick } from './styled-button-i'
  enum TabPositions {
    between = 'between',
    left = 'left',
    right = 'right',
  }
  export default defineComponent({
    name: 'tab',
    components: {
      StyledButton: defineAsyncComponent(() => import('./styled-button.vue')),
    },
    emits: styledButtonEmits,
    props: {
      position: {
        type: String,
        default: TabPositions.between,
        required: false,
      },
      isActive: {
        type: Boolean,
        default: false,
        required: false,
      },
    },
    setup(props, context) {
      const cornerClass = computed(() => {
        const position = props.position as TabPositions
        switch (position) {
          case TabPositions.left:
            return 'border-top-right-corner-80'
          case TabPositions.right:
            return 'border-top-left-corner-80'
          case TabPositions.between:
          default:
            break
        }
      })

      const classes = computed(() => {
        return [cornerClass.value].join(' ')
      })
      return { classes, click: styledButtonClick({ context }) }
    },
  })
</script>

<style></style>
