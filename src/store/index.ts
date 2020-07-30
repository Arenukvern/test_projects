import Vue from 'vue'
import Vuex from 'vuex'
import { CardsModule } from './CardsModule'

Vue.use(Vuex)

export enum VuexModules {
  CardsModule = 'cardsModule',
}
export default new Vuex.Store({
  modules: {
    cardsModule: CardsModule,
  },
})
