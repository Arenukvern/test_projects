export type FieldValidationCallback = ({ value }: { value: string }) => boolean
export const FieldValidationCallbackGuard = ({ func }: { func: Function }) =>
  func as FieldValidationCallback
