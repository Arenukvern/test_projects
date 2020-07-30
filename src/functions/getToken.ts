import { Constants } from '@/constants/Constants'

export const getToken = () => localStorage.getItem(Constants.token)
export const createToken = (token: string) => {
  // `JWT ${token}`
  const newToken = `JWT ${token}`
  return newToken
}
export const cleanToken = (token: string) => token.replace('JWT ', '')
