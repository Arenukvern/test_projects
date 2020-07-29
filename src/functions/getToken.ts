import { Constants } from '@/constants/Constants'

export const getToken = () => localStorage.getItem(Constants.token)
