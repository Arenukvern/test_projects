<template lang="pug">
.app.back-color-seashell.color-coffee-bean
  img.absolute.b-0.l-0.z-0(:src='"./assets/tree.svg"' alt="a tree" )
  .grid.columns-1.rows-90p.h-full.relative.z-10
    .column.center
      .column.h-18.w-14
        p.text.center.h4 {{welcome}}
        .h-4
        div(
          class=`
            column
            main-align-start
            transition-duration-04
            transition-all
            transition-easy 
          `
        )
          field(
            v-show='isEmailStep || isSignUp'
            placeholder='email'
            type='email'
            v-model='email'
            :validationCallback='emailValidator'
            :errorMessage='emailErrorMessage'
            :required='true'
          )
            template(v-slot:suffix)
              transition(name="fade")
                icon-button.ml-4(
                  v-show='isSignIn'
                  @click='verifyEmail'
                )
                  img(:src='"./assets/send.svg"')
          transition(name="fade-1")
            field(
              v-show='isPasswordStep || isSignUp'
              placeholder='password'
              type='password'
              v-model='password'
              :validationCallback='passwordValidator'
              :errorMessage='passwordErrorMessage'
              :required='true'
            )
              template(v-slot:suffix)
                transition(name="fade")
                  icon-button.ml-4(v-show='isSignIn')
                    img(:src='"./assets/send.svg"')
          transition(name="fade")
            field(
              v-show='isSignUp'
              placeholder='confirm password'
              type='password'
              v-model='confirmPassword'
              :validationCallback='confirmPasswordValidator'
              :errorMessage='confirmPasswordErrorMessage'
              :required='true'
            )
              template(v-slot:suffix)
                icon-button.ml-4
                  img(:src='"./assets/send.svg"')

    .row.cross-align-end
      tab(
        :isActive='isSignIn'
        @click='enableSignIn'
        position='left'
      ) Sign in
      tab(
        :isActive='isSignUp'
        @click='enableSignUp'
        position='right'
      ) Sign up
</template>

<script lang="ts">
  import { computed, defineAsyncComponent, defineComponent, ref } from 'vue'
  import { FieldValidationCallback } from './components-core/field-i'
  enum Mode {
    signin,
    signup,
  }
  enum SignInSteps {
    email,
    password,
  }
  export default defineComponent({
    name: 'App',
    components: {
      Field: defineAsyncComponent(() => import('./components-core/field.vue')),
      IconButton: defineAsyncComponent(
        () => import('./components-core/icon-button.vue')
      ),
      Tab: defineAsyncComponent(() => import('./components-core/tab.vue')),
    },
    setup() {
      const currentMode = ref(Mode.signin)
      const isSignIn = computed(() => currentMode.value == Mode.signin)
      const isSignUp = computed(() => currentMode.value == Mode.signup)
      const enableSignIn = () => {
        currentMode.value = Mode.signin
        currentSignInStep.value = SignInSteps.email
      }
      const enableSignUp = () => (currentMode.value = Mode.signup)

      // Sign in steps

      const currentSignInStep = ref(SignInSteps.email)
      const isPasswordStep = computed(
        () => currentSignInStep.value == SignInSteps.password
      )
      const isEmailStep = computed(
        () => currentSignInStep.value == SignInSteps.email
      )
      const welcome = computed(() => {
        switch (currentMode.value) {
          case Mode.signin:
            return 'Welcome back'
          case Mode.signup:
          default:
            return 'Registraion'
        }
      })

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
      const verifyEmail = () => {
        //TODO: check is email exists
        const isEmailExists = true
        if (isEmailExists) {
          currentSignInStep.value = SignInSteps.password
        } else {
          currentSignInStep.value = SignInSteps.email
          currentMode.value = Mode.signup
        }
      }
      const password = ref('')
      const passwordValidator: FieldValidationCallback = ({ value }) =>
        value.length > 4

      const confirmPassword = ref('')
      const confirmPasswordValidator: FieldValidationCallback = ({ value }) =>
        value == password.value

      return {
        isPasswordStep,
        isEmailStep,
        welcome,
        email,
        emailValidator,
        emailErrorMessage,
        verifyEmail,
        password,
        passwordValidator,
        confirmPassword,
        confirmPasswordValidator,
        isSignIn,
        isSignUp,
        enableSignIn,
        enableSignUp,
      }
    },
  })
</script>

<style></style>
