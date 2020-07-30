import { api } from '@/constants/Api'
import { RequestMethods } from '@/constants/RequestMethods'
import { User } from '@/entities/User'
import { FetchService } from './FetchService'
export namespace AuthService {
  export interface createUserArg {
    username: User['username']
    email: User['email']
    password: User['password']
  }
  export interface loginArg {
    username: User['username']
    password: User['password']
  }
  export interface refreshTokenArg {
    token: User['token']
  }
}
export class AuthService {
  async createUser(arg: AuthService.createUserArg) {
    const url = api.users.create
    return await FetchService.request(arg, RequestMethods.post, url)
  }
  async login(arg: AuthService.loginArg) {
    const url = api.users.login

    return await FetchService.request(arg, RequestMethods.post, url)
  }
  async refreshToken(arg: AuthService.refreshTokenArg) {
    const url = api.users.refreshToken
    return await FetchService.request(arg, RequestMethods.post, url, false)
  }
}
