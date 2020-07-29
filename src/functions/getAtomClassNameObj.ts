import { ClassName } from '@/entities/ClassName'

export const getAtomClassNameObj = (accentNames: string[]) => {
  let obj: ClassName = new ClassName()
  for (let accent of accentNames) {
    obj[`--is-${accent}`] = true
  }
  return obj
}
