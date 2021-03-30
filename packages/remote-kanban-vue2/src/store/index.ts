import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from 'vuex-persistedstate'
import { CardsModule } from './CardsModule'

Vue.use(Vuex)

export enum VuexModules {
  CardsModule = 'cardsModule',
}
export default new Vuex.Store({
  modules: {
    cardsModule: CardsModule,
  },
  plugins: [createPersistedState()],
})
