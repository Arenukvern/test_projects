import { BoardColumns } from '@/constants/BoardColumns'
import { Card } from '@/entities/Card'
import { CardService } from '@/services/CardService'
import Vue from 'vue'
export module CardsModuleI {
  export interface state {
    rows: {
      [rowId: string]: Card[]
    }
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
  const st: CardsModuleI.state = {
    rows: {
      0: [],
      1: [],
      2: [],
      3: [],
    },
  }
  return st
}
const getters = {
  [CardsModuleI.getters.cards](state: CardsModuleI.state) {
    return state.rows
  },
}
const mutations = {
  [CardsModuleI.mutations.save](state: CardsModuleI.state, card: Card) {
    const cards = state.rows[card.row]

    const index = cards.findIndex(el => el.id == card.id)
    if (index >= 0) {
      cards.splice(index, 1, card)
    } else {
      cards.unshift(card)
    }
    Vue.set(state.rows, card.row, cards)
  },
  [CardsModuleI.mutations.delete](state: CardsModuleI.state, card: Card) {
    const cards = state.rows[card.row]

    const index = cards.findIndex(el => el.id == card.id)
    if (index >= 0) {
      cards.splice(index, 1)
    }
    Vue.set(state.rows, card.row, cards)
  },

  [CardsModuleI.mutations.saveAll](
    state: CardsModuleI.state,
    { cards, row }: { row: Card['row']; cards: Card[] }
  ) {
    Vue.set(state.rows, row, cards)
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
    for (const row in BoardColumns) {
      const resp = await service.get({ row })
      if (resp.ok) {
        commit(CardsModuleI.mutations.saveAll, {
          row,
          cards: await resp.json(),
        })
      } else {
        //
      }
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
