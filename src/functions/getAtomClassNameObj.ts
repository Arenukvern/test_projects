import { ClassName } from '@/entities/ClassName'

export const getAtomClassNameObj = (atomNames: string[]) => {
  const obj: ClassName = new ClassName()
  for (const atom of atomNames) {
    if (atom != '') {
      obj[`--is-${atom}`] = true
    }
  }
  return obj
}
