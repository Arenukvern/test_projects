<template lang="pug">
div
  p.text.center.h4 {{title}}
  .h-4
  transition-group(name="fade-group" tag='div')
    .column.main-align-start.fade-group-item(
      key='register' v-if='isRegister'
    )
      field(
        placeholder='email'
        type='email'
        v-model='email'
        :validationCallback='emailValidator'
        :errorMessage='emailErrorMessage'
        :required='true'
        @updateIsValueValid='isValid=>isEmailValid = isValid'
        :showErrorMessage='isEmailExists'
        :hightlightSuccess='!isEmailExists && isEmailValid'
      )
      field(
        placeholder='password'
        type='password'
        v-model='password'
        :validationCallback='passwordValidator'
        :errorMessage='passwordLengthErrorMessage'
        :required='true'
        @updateIsValueValid='isValid=>isPasswordValid = isValid'
        :hightlightSuccess='isPasswordValid'
      )
      field(
        placeholder='confirm password'
        type='password'
        v-model='passwordConfirmation'
        :validationCallback='passwordConfirmationValidator'
        errorMessage='Password doesn\'t match'
        :required='true'
        @updateIsValueValid='isValid=>isPasswordConfirmationValid = isValid'
        :hightlightSuccess='isPasswordConfirmationValid'
      )
        template(v-slot:suffix)
          transition(name="fade")
            icon-button.ml-4(
              v-show='isReadyToRegister'
              @click='register'
            )
              img(:src='"./assets/send.svg"')
    .column.main-align-start.fade-group-item(
      key='registered' 
      v-if='isRegistered'
    )
      .p You succefully registered!       
      styled-button(@click='openSignIn') Sign in
</template>

<script lang="ts">
  import { FieldValidationCallback } from '#/components-core/field-i'
  import { UserModel } from '#/composable'
  import { computed, defineAsyncComponent, defineComponent, ref } from 'vue'
  import { useEmail } from './email'
  import { usePassword } from './password'
  enum SignUpSteps {
    register,
    registered,
  }
  enum Emits {
    openSignIn = 'openSignIn',
  }
  export default defineComponent({
    name: 'sign-up',
    components: {
      Field: defineAsyncComponent(() => import('#/components-core/field.vue')),
      IconButton: defineAsyncComponent(
        () => import('#/components-core/icon-button.vue')
      ),
      StyledButton: defineAsyncComponent(
        () => import('#/components-core/styled-button.vue')
      ),
    },
    emits: [Emits.openSignIn],
    setup(_props, context) {
      const currentStep = ref(SignUpSteps.register)
      const isRegister = computed(
        () => currentStep.value == SignUpSteps.register
      )
      const isRegistered = computed(
        () => currentStep.value == SignUpSteps.registered
      )
      const {
        email,
        isEmailNotEmpty,
        isEmailValid,
        emailValidator,
        isEmailExists,
        emailFormatErrorMessage,
      } = useEmail()
      const {
        password,
        passwordLengthErrorMessage,
        user,
        isPasswordValid,
        passwordValidator,
      } = usePassword({ email })
      const emailErrorMessage = computed(() => {
        if (isEmailExists.value)
          return 'this email already exists, try different'
        return emailFormatErrorMessage
      })

      const title = computed(() => {
        switch (true) {
          case isRegister.value:
            return 'Register'
          case isRegistered.value:
          default:
            return ''
        }
      })
      const passwordConfirmation = ref('')
      const isPasswordConfirmationValid = ref(false)
      const passwordConfirmationValidator: FieldValidationCallback = ({
        value,
      }) => value == password.value
      const isReadyToRegister = computed(
        () =>
          isPasswordValid.value &&
          isPasswordConfirmationValid.value &&
          isEmailValid &&
          !isEmailExists.value
      )
      const register = () => {
        UserModel.create({
          user: user.value,
        })
        currentStep.value = SignUpSteps.registered
      }
      const openSignIn = () => {
        context.emit(Emits.openSignIn, user.value)
      }
      return {
        openSignIn,
        title,
        email,
        isEmailNotEmpty,
        emailErrorMessage,
        isEmailValid,
        emailValidator,
        isEmailExists,
        password,
        passwordLengthErrorMessage,
        user,
        isPasswordValid,
        passwordValidator,
        isRegister,
        isRegistered,
        passwordConfirmation,
        isPasswordConfirmationValid,
        passwordConfirmationValidator,
        isReadyToRegister,
        register,
      }
    },
  })
</script>
