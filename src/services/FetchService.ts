import { Constants } from '@/constants/Constants'
import { RequestMethods } from '@/constants/RequestMethods'
import { cleanToken, createToken, getToken } from '@/functions/getToken'
import { AuthService } from './AuthService'

const toFormData = (data: any) => {
  const formData = new FormData()
  for (const key in data) {
    formData.append(key, data[key])
  }
  return formData
}
export class FetchService {
  static async request(
    body: any | undefined,
    requestMethod: RequestMethods,
    url: string,
    checkToken: boolean = true,
    urlSearchParams?: URLSearchParams
  ) {
    const headers = new Headers()
    const checkAndRefreshToken = async () => {
      const token = getToken()
      if (token !== null) {
        const authService = new AuthService()
        const resp = await authService.refreshToken({
          token: cleanToken(token),
        })
        if (resp.ok) {
          const newToken = createToken(
            ((await resp.json()) as AuthService.refreshTokenArg).token
          )
          headers.append('Authorization', newToken)
          localStorage.setItem(Constants.token, newToken)
        }
      }
    }

    if (checkToken) {
      await checkAndRefreshToken()
    } else {
      const token = getToken()
      if (token) {
        headers.append('Authorization', token)
      }
    }
    const obj: RequestInit = {
      method: requestMethod,
      headers,
    } as RequestInit
    if (body) {
      obj.body = toFormData(body)
    }
    const urlObj = new URL(url)
    if (urlSearchParams) urlObj.search = urlSearchParams.toString()
    const resp: Response = await fetch(urlObj.href, obj)
    return resp
  }
}
