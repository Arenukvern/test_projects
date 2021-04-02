<template lang="pug">
.app.back-color-seashell.color-coffee-bean
  img.absolute.b-0.l-0.z-0(:src='"./assets/tree.svg"' alt="a tree" )
  .grid.columns-1.rows-90p.h-full.relative.z-10
    .column.center
      .column.h-18.w-14
        p.text.center.h4 {{welcome}}
        .h-4
        .column.main-align-start(
          v-if='isSignIn || isSignUp'
        )
          field(
            v-show='isEmailStep || isSignUp'
            placeholder='email'
            type='email'
            v-model='email'
            :validationCallback='emailValidator'
            :errorMessage='emailErrorMessage'
            :required='true'
            @updateIsValueValid='isValid=>isEmailValid = isValid'
          )
            template(v-slot:suffix)
              transition(name="fade")
                icon-button.ml-4(
                  v-show='isSignIn && isEmailNotEmpty && isEmailValid'
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
              @updateIsValueValid='isValid=>isPasswordValid = isValid'
            )
              template(v-slot:suffix)
                transition(name="fade")
                  icon-button.ml-4(
                    v-show='isSignIn && isPasswordValid'
                    @click='confirmPassword'  
                  )
                    img(:src='"./assets/send.svg"')
          transition(name="fade-1")
            styled-button.h-2.border-radius-5(
              v-show='isPasswordStep && isSignIn'
              mainAlignClass="main-align-left cross-align-center"
              @click='forgotPassword'
            ) 
              .ml-4 Forgot password?
          transition(name="fade")
            field(
              v-show='isSignUp'
              placeholder='confirm password'
              type='password'
              v-model='passwordConfirmation'
              :validationCallback='passwordConfirmationValidator'
              errorMessage='Password doesn\'t match'
              :required='true'
              @updateIsValueValid='isValid=>isPasswordConfirmationValid = isValid'
            )
              template(v-slot:suffix)
                transition(name="fade")
                  icon-button.ml-4(
                    v-show='isReadyToRegister'
                    @click='register'
                  )
                    img(:src='"./assets/send.svg"')
        transition(name="fade-1")
          .column.main-align-start(
            v-if='isPasswordRecovery'
          )
            .p.mb-8 We sent email to {{email}} with password change instructions. 
            .p Please follow them to recover your password safely. 
        transition(name="fade-1")
          .column.main-align-start(
            v-if='isAuthorized'
          )
            .p You succefully authorized!
        transition(name="fade-1")
          .column.main-align-start(
            v-if='isRegistered'
          )
            .p You succefully registered! 
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
    authorized,
    registered,
    passwordRecovery,
  }
  enum SignInSteps {
    email,
    password,
  }
  export default defineComponent({
    name: 'App',
    components: {
      Field: defineAsyncComponent(() => import('./components-core/field.vue')),
      StyledButton: defineAsyncComponent(
        () => import('./components-core/styled-button.vue')
      ),
      IconButton: defineAsyncComponent(
        () => import('./components-core/icon-button.vue')
      ),
      Tab: defineAsyncComponent(() => import('./components-core/tab.vue')),
    },
    setup() {
      // =============== Mods ================
      const currentMode = ref(Mode.signin)
      const isSignIn = computed(() => currentMode.value == Mode.signin)
      const isSignUp = computed(() => currentMode.value == Mode.signup)
      const isPasswordRecovery = computed(
        () => currentMode.value == Mode.passwordRecovery
      )
      const isAuthorized = computed(() => currentMode.value == Mode.authorized)
      const isRegistered = computed(() => currentMode.value == Mode.registered)
      const enableSignIn = () => {
        currentMode.value = Mode.signin
        currentSignInStep.value = SignInSteps.email
      }
      const enableSignUp = () => (currentMode.value = Mode.signup)

      //  =========== Sign in steps =============

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
            return 'Registraion'
          case Mode.passwordRecovery:
            return 'Password recovery'
          case Mode.registered:
          case Mode.authorized:
          default:
            return ''
        }
      })
      //  =========== email =============

      const email = ref('')
      const isEmailNotEmpty = computed(() => email.value.length)
      const isEmailValid = ref(false)
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

      //  =========== password =============

      const password = ref('')
      const passwordValidator: FieldValidationCallback = ({ value }) =>
        value.length > 4
      // Validation by password validator
      const isPasswordValid = ref(false)
      // Validation from server request
      const isWrongPassword = ref(false)
      const passwordErrorMessage = computed(() => {
        if (isWrongPassword.value) return 'Wrong password. Please try another'
        return 'Password must have at least 5 symbols'
      })
      const confirmPassword = () => {
        // TODO: check with local storage
        const isAuthorized = true
        if (isAuthorized) {
          isWrongPassword.value = false
          currentMode.value = Mode.authorized
        } else {
          isWrongPassword.value = true
        }
      }
      const forgotPassword = () => {
        currentMode.value = Mode.passwordRecovery
      }
      //  =========== confirm password =============

      const passwordConfirmation = ref('')
      const isPasswordConfirmationValid = ref(false)
      const passwordConfirmationValidator: FieldValidationCallback = ({
        value,
      }) => value == password.value
      const isReadyToRegister = computed(
        () =>
          isPasswordValid.value &&
          isPasswordConfirmationValid.value &&
          isEmailValid
      )
      const register = () => {
        // TODO: write to local storage
        currentMode.value = Mode.registered
      }
      return {
        isPasswordStep,
        isEmailStep,
        welcome,
        email,
        isEmailNotEmpty,
        emailValidator,
        emailErrorMessage,
        isEmailValid,
        passwordErrorMessage,
        verifyEmail,
        password,
        passwordValidator,
        isPasswordValid,
        confirmPassword,
        passwordConfirmation,
        passwordConfirmationValidator,
        isPasswordConfirmationValid,
        register,
        isReadyToRegister,
        isSignIn,
        isSignUp,
        enableSignIn,
        enableSignUp,
        isPasswordRecovery,
        isAuthorized,
        isRegistered,
        forgotPassword,
      }
    },
  })
</script>

<style></style>
