import { api } from '@/constants/Api'
import { RequestMethods } from '@/constants/RequestMethods'
import { Card } from '@/entities/Card'
import { FetchService } from './FetchService'

export module CardService {
  export interface createArg {
    row: string
    text: Card['text']
  }
  export interface updateArg {
    row: string
    seq_num: number
    text: Card['text']
  }
  export interface getArg {
    row: string
  }
}

export class CardService {
  async create(arg: CardService.createArg) {
    return await FetchService.request(arg, RequestMethods.post, `${api.cards}`)
  }
  async update(arg: CardService.updateArg, cardId: Card['id']) {
    return await FetchService.request(
      arg,
      RequestMethods.patch,
      `${api.cards}${cardId}/`
    )
  }
  async delete(cardId: Card['id']) {
    return await FetchService.request(
      undefined,
      RequestMethods.delete,
      `${api.cards}${cardId}/`
    )
  }
  async get(arg?: CardService.getArg) {
    const urlParams: URLSearchParams = new URLSearchParams()
    if (arg) urlParams.append('row', arg.row)
    return await FetchService.request(
      undefined,
      RequestMethods.get,
      `${api.cards}`,
      true,
      urlParams
    )
  }
}
