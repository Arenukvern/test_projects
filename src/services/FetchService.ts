import { RequestMethods } from '@/constants/RequestMethods'
import { getToken } from '@/functions/getToken'

const headers = new Headers()
const token = getToken()
if (token !== null) {
  headers.append('Authorization', token)
}
const toFormData = (data: any) => {
  const formData = new FormData()
  for (const key in data) {
    formData.append(key, data[key])
  }
  return formData
}
export class FetchService {
  static async request(body: any, requestMethod: RequestMethods, url: string) {
    const obj: RequestInit = {
      method: requestMethod,
      body: toFormData(body),
      headers,
    } as RequestInit
    console.log(obj)
    const resp: Response = await fetch(url, obj)
    return resp
  }
}
