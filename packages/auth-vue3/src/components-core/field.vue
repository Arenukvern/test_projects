<template lang="pug">
.column.h-4
  .row.cross-align-center
    input(
      :type='type'
      :class='classes'
      :placeholder='placeholder'
      v-model="val"
      :required='required'
    )
    slot(name='suffix')
  transition(name="fade")
    div.mt-4(v-show='isValNotCorrect'
      class=`
        transition-duration-04
        transition-all
        transition-easy
      `
    )
      div.color-maroon.second-subtitle {{errorMessage}}
  
</template>

<script lang="ts">
  import { computed, defineComponent, ref, watch } from 'vue'
  import { FieldValidationCallbackGuard } from './field-i'
  enum Emits {
    'updateModelValue' = 'update:modelValue',
    'updateIsValueValid' = 'update-is-valid-value',
  }
  interface ThemeOptions {
    core: string
    error: string
    default: string
    background: string
  }
  const coreClasses = `
    h-2
    hover-back-coffee-bean-2

    focus-back-coffee-bean-5
    focus-shadow-26-coffee-bean-4

    border-radius-5
    border-bottom-1
    border-bottom-dashed

    pl-4
    pr-4

    transition-duration-04
    transition-all
    transition-easy
  `
  const theme: { light: ThemeOptions; dark: ThemeOptions } = {
    light: {
      core: coreClasses,
      error: 'border-bottom-color-maroon',
      default: 'border-bottom-color-coffee-bean',
      background: 'back-color-seashell',
    },
    dark: {
      core: coreClasses,
      error: 'border-bottom-color-maroon',
      default: `border-bottom-color-seashell`,
      background: 'back-color-coffee-bean',
    },
  }
  export default defineComponent({
    name: 'field',
    props: {
      type: {
        type: String,
        default: 'text',
        required: false,
      },
      placeholder: {
        type: String,
        default: '',
        required: false,
      },
      required: {
        type: Boolean,
        default: false,
        required: false,
      },
      modelValue: {
        type: String,
        defalut: '',
        required: false,
      },
      validationCallback: {
        type: Function,
        default: () => true,
        required: false,
      },
      isDark: {
        type: Boolean,
        default: false,
        required: false,
      },
      errorMessage: {
        type: String,
        default: 'wrong value',
        required: false,
      },
    },
    emits: [Emits.updateModelValue, Emits.updateIsValueValid],
    setup(props, context) {
      const validateField = FieldValidationCallbackGuard({
        func: props.validationCallback,
      })
      const val = computed<string>({
        set: (value) => context.emit(Emits.updateModelValue, value),
        get: () => props.modelValue ?? '',
      })

      const isValCorrect = ref(true)
      const isValNotCorrect = computed(() => !isValCorrect.value)
      watch(val, () => {
        const isValid = validateField({ value: val.value })
        isValCorrect.value = isValid
        context.emit(Emits.updateIsValueValid, isValid)
      })

      const classes = computed(() => {
        const currentThemeName = props.isDark ? 'dark' : 'light'
        const currentTheme = theme[currentThemeName]
        const resolvedBorderClass = isValCorrect.value
          ? currentTheme.default
          : currentTheme.error
        return [
          currentTheme.core,
          currentTheme.background,
          resolvedBorderClass,
        ].join(' ')
      })
      return { val, classes, isValNotCorrect }
    },
  })
</script>
