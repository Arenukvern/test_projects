<template lang="pug">
div
  p.text.center.h4 {{title}}
  .h-4
  transition-group(:name="'fade-group'" tag='div')
    .column.main-align-start.fade-group-item(
      v-if='!isAuthorized && !isPasswordRecovery'
      key='isAuth'
    )
      field(
        v-show='isEmailStep'
        placeholder='email'
        type='email'
        v-model='email'
        @keyup.enter="verifyEmail"
        :validationCallback='emailValidator'
        :errorMessage='emailErrorMessage'
        :required='true'
        @updateIsValueValid='isValid=>isEmailValid = isValid'
        :showErrorMessage='!isEmailReady'
      )
        template(v-slot:suffix)
          transition(name="fade")
            icon-button.ml-4(
              v-show='isEmailReady'
              @click='verifyEmail'
            )
              img(:src='"./assets/send.svg"')
      transition(name="fade-1")
        field(
          v-show='isPasswordStep'
          placeholder='password'
          type='password'
          v-model='password'
          :validationCallback='passwordValidator'
          :errorMessage='passwordErrorMessage'
          :required='true'
          @updateIsValueValid='isValid=>isPasswordValid = isValid'
          @keyup.enter="confirmPassword"
          :showErrorMessage='isWrongPassword'
        )
          template(v-slot:suffix)
            transition(name="fade")
              icon-button.ml-4(
                v-show='isPasswordValid'
                @click='confirmPassword'  
              )
                img(:src='"./assets/send.svg"')
      transition(name="fade-1")
        styled-button.h-2.border-radius-5(
          v-show='isPasswordStep'
          mainAlignClass="main-align-left cross-align-center"
          @click='forgotPassword'
        ) 
          .ml-4 Forgot password?
    .column.fade-group-item(key='isAuthorized' v-if='isAuthorized')
      .p You succefully authorized!
      styled-button(@click='enableEmailStep') Back
    .column.fade-group-item(key='isPasswordRecovery' v-if='isPasswordRecovery')
      .p.mb-8 We sent email to {{email}} with password change instructions. 
      .p Please follow them to recover your password safely. 
      styled-button(@click='enableEmailStep') Back
</template>

<script lang="ts">
  import { UserModel } from '#/composable'
  import {
    computed,
    defineAsyncComponent,
    defineComponent,
    onMounted,
    ref,
    watch,
  } from 'vue'
  import { useEmail } from './email'
  import { usePassword } from './password'
  enum SignInSteps {
    email,
    password,
    passwordRecovery,
    authorized,
  }
  enum Emits {
    switchToSignUp = 'switchToSignUp',
  }
  export default defineComponent({
    name: 'sign-in',
    emits: [Emits.switchToSignUp],
    props: {
      email: {
        type: String,
        default: '',
        required: false,
      },
    },
    components: {
      Field: defineAsyncComponent(() => import('#/components-core/field.vue')),
      StyledButton: defineAsyncComponent(
        () => import('#/components-core/styled-button.vue')
      ),
      IconButton: defineAsyncComponent(
        () => import('#/components-core/icon-button.vue')
      ),
    },
    setup(props) {
      const currentSignInStep = ref(SignInSteps.email)
      const isPasswordStep = computed(
        () => currentSignInStep.value == SignInSteps.password
      )
      const enableEmailStep = () =>
        (currentSignInStep.value = SignInSteps.email)

      const isEmailStep = computed(
        () => currentSignInStep.value == SignInSteps.email
      )
      const isPasswordRecovery = computed(
        () => currentSignInStep.value == SignInSteps.passwordRecovery
      )
      const isAuthorized = computed(
        () => currentSignInStep.value == SignInSteps.authorized
      )

      // ============= email =============
      const {
        email,
        isEmailExists,
        emailValidator,
        isEmailValid,
        isEmailNotEmpty,
        emailFormatErrorMessage,
      } = useEmail()
      const assignEmailFromProp = () => (email.value = props.email)
      watch(props, () => {
        assignEmailFromProp()
      })
      onMounted(() => {
        assignEmailFromProp()
      })

      const verifyEmail = () => {
        if (isEmailExists.value) {
          currentSignInStep.value = SignInSteps.password
        } else {
          // TODO; ask to sign up
          // context.emit(Emits.switchToSignUp)
        }
      }
      const isEmailReady = computed(
        () => isEmailValid.value && isEmailExists.value
      )
      const emailErrorMessage = computed(() => {
        if (!isEmailValid.value) return emailFormatErrorMessage
        if (!isEmailExists.value)
          return 'this email is not registered, please sign up'
        return ''
      })

      // ======== password ========
      const {
        password,
        passwordValidator,
        isPasswordValid,
        user,
        passwordLengthErrorMessage,
      } = usePassword({ email })
      const isWrongPassword = ref(false)
      const passwordErrorMessage = computed(() => {
        if (isWrongPassword.value) return 'wrong password, please try another'
        return passwordLengthErrorMessage
      })
      const confirmPassword = () => {
        const isAuthorized = UserModel.isPasswordValidForEmail({
          user: user.value,
        })
        if (isAuthorized) {
          isWrongPassword.value = false
          currentSignInStep.value = SignInSteps.authorized
        } else {
          isWrongPassword.value = true
        }
      }

      // ========== title =============
      const title = computed(() => {
        switch (currentSignInStep.value) {
          case SignInSteps.email:
          case SignInSteps.password:
            return 'Welcome back'
          case SignInSteps.passwordRecovery:
            return 'Password recovery'
          case SignInSteps.authorized:
          default:
            return ''
        }
      })

      const forgotPassword = () => {
        currentSignInStep.value = SignInSteps.passwordRecovery
      }
      return {
        title,
        email,
        isEmailExists,
        emailErrorMessage,
        emailValidator,
        isEmailValid,
        isEmailNotEmpty,
        enableEmailStep,
        verifyEmail,
        isPasswordStep,
        isEmailStep,
        isPasswordRecovery,
        isAuthorized,
        isWrongPassword,
        passwordErrorMessage,
        password,
        passwordValidator,
        isPasswordValid,
        user,
        confirmPassword,
        forgotPassword,
        isEmailReady,
      }
    },
  })
</script>
