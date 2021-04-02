import { User } from '#/abstract'
import { FieldValidationCallback } from '#/components-core/field-i'
import { computed, ref, Ref } from 'vue'

const usePassword = ({ email }: { email: Ref<User['email']> }) => {
  const password = ref('')
  const passwordValidator: FieldValidationCallback = ({ value }) =>
    value.length > 4
  // Validation from server request
  const isPasswordValid = ref(false)
  const user = computed<User>(() => {
    const usr: User = { email: email.value, password: password.value }
    return usr
  })
  const passwordLengthErrorMessage = 'password must have at least 5 symbols'

  return {
    password,
    passwordValidator,
    isPasswordValid,
    user,
    passwordLengthErrorMessage,
  }
}
export { usePassword }
