import { FieldValidationCallback } from '#/components-core/field-i'
import { UserModel } from '#/composable'
import { computed, ref } from 'vue'

const useEmail = () => {
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
  const isEmailExists = computed(() =>
    UserModel.isEmailExists({ email: email.value })
  )
  const emailFormatErrorMessage =
    'please provide email in format: name@something.com'
  return {
    email,
    isEmailExists,
    emailValidator,
    isEmailValid,
    isEmailNotEmpty,
    emailFormatErrorMessage,
  }
}
export { useEmail }
