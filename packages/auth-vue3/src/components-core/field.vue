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
  v-model="val"
)
</template>

<script lang="ts">
  import { computed, defineComponent } from 'vue'
  enum Emits {
    'updateModelValue' = 'update:modelValue',
  }
  export default defineComponent({
    name: 'field',
    props: {
      placeholder: {
        type: String,
        default: '',
        required: false,
      },
      modelValue: {
        type: String,
        defalut: '',
        required: false,
      },
    },
    emits: [Emits.updateModelValue],
    setup(props, context) {
      const val = computed<string>({
        set: (value) => context.emit(Emits.updateModelValue, value),
        get: () => props.modelValue ?? '',
      })
      return { val }
    },
  })
</script>
