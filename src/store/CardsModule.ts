import { Card } from '@/entities/Card'
import { CardService } from '@/services/CardService'
import Vue from 'vue'
export module CardsModuleI {
  export interface state {
    cards: Card[]
  }
  export enum getters {
    cards = 'cards',
  }
  export enum mutations {
    save = 'save',
    saveAll = 'saveAll',
    delete = 'delete',
  }
  export enum actions {
    get = 'get',
  }
}

const state = () => {
  const st: CardsModuleI.state = { cards: [] }
  return st
}
const getters = {
  [CardsModuleI.getters.cards](state: CardsModuleI.state) {
    return state.cards
  },
}
const mutations = {
  [CardsModuleI.mutations.save](state: CardsModuleI.state, card: Card) {
    const index = state.cards.findIndex(el => el.id == card.id)
    if (index >= 0) {
      state.cards.splice(index, 1, card)
    } else {
      state.cards.unshift(card)
    }
  },
  [CardsModuleI.mutations.delete](state: CardsModuleI.state, card: Card) {
    const index = state.cards.findIndex(el => el.id == card.id)
    if (index >= 0) {
      state.cards.splice(index, 1)
    }
  },

  [CardsModuleI.mutations.saveAll](state: CardsModuleI.state, cards: Card[]) {
    Vue.set(state.cards, 'cards', cards)
  },
}
const actions = {
  async [CardsModuleI.actions.get]({
    commit,
    state,
  }: {
    state: CardsModuleI.state
    commit: any
  }) {
    const service = new CardService()
    const resp = await service.get()
    if (resp.ok) {
      commit(CardsModuleI.mutations.saveAll, await resp.json())
    } else {
      //
    }
  },
}

export const CardsModule = {
  namespaced: true,
  state,
  getters,
  mutations,
  actions,
}
