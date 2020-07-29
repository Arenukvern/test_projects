import { ClassName } from '@/entities/ClassName'

export const getAtomClassNameObj = (accentNames: string[]) => {
  const obj: ClassName = new ClassName()
  for (const accent of accentNames) {
    obj[`--is-${accent}`] = true
  }
  return obj
}
