<template lang="pug">
img.absolute.b-0.l-0.z-0(:src='"./assets/tree.svg"' alt="a tree" )
.grid.columns-1.rows-90p.h-full.relative.z-10
  .column.center
    .column.main-align-space-between.h-8
      p.text.center.h4 Welcome back
      field.mr-4(
        placeholder='email'
        type='email'
        v-model='email'
        :validationCallback='emailValidator'
        :errorMessage='emailErrorMessage'
        :required='true'
      )
        template(v-slot:suffix)
          icon-button.ml-4
            img(:src='"./assets/send.svg"')
  .row.cross-align-end
    styled-button.h5.border-top-right-corner-80(:isDark='true') Sign in
    styled-button.h5 Sign up
</template>

<script lang="ts">
  import { defineAsyncComponent, defineComponent, ref } from 'vue'
  import { FieldValidationCallback } from './components-core/field-i'

  export default defineComponent({
    name: 'App',
    components: {
      Field: defineAsyncComponent(() => import('./components-core/field.vue')),
      IconButton: defineAsyncComponent(
        () => import('./components-core/icon-button.vue')
      ),
      StyledButton: defineAsyncComponent(
        () => import('./components-core/styled-button.vue')
      ),
    },
    setup() {
      const email = ref('')
      const emailValidator: FieldValidationCallback = ({ value }) => {
        // according to spec:
        // https://html.spec.whatwg.org/multipage/input.html#valid-e-mail-address
        const r = value.search(
          /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/
        )
        return r >= 0 && value.includes('.')
      }
      const emailErrorMessage =
        'please provide email in format: name@something.com'
      const password = ref('')
      const confirmPassword = ref('')

      return {
        email,
        emailValidator,
        emailErrorMessage,
        password,
        confirmPassword,
      }
    },
  })
</script>

<style></style>
