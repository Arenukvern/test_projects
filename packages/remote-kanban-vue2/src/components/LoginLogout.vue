<template lang="pug">
.card
  .card__title.--has-text-centered.--has-text-accent Welcome{{isSignIn ? ' back': ''}}!
  .card__body 
    .column
      p.p.--has-text-accent(v-if='!isSignIn').
        It seems that you don't have an account. 
        Please sign up
      v-input(v-model='user.username' :errors='errors.username' label='Username')
      v-input(v-if='!isSignIn' v-model='user.email' :errors='errors.email' label='E-mail')
      v-input(v-model='user.password' :errors='errors.password' label='Password')
      v-btn(@click='submit') {{submitBtnTitle}}
  .card__actions
    p.p If you {{isSignIn ? `don't have an`: 'have an'}} account 
    v-btn(@click='isSignIn = !isSignIn') {{signInSignOutBtnTitle}}
</template>
<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'
import { StatelessComponentsRouter } from '../componentsRouter'
import { User } from '../entities/User'
import { AuthService } from '@/services/AuthService'
import { Constants } from '../constants/Constants'
import { RoutesPaths } from '../constants/RoutesPaths'
import { getToken, createToken } from '../functions/getToken'

const VBtn = StatelessComponentsRouter.VBtn
const VInput = StatelessComponentsRouter.VInput

@Component({
  components: {
    VBtn,
    VInput,
  },
})
export default class LoginLogoutComponent extends Vue {
  user: User = new User()
  errors: User = new User()
  isSignIn: boolean = true
  mounted() {
    const token = getToken()
    this.user.token = token ?? ''
  }
  get submitBtnTitle() {
    return this.isSignIn ? 'Login' : 'Sign up'
  }
  get signInSignOutBtnTitle() {
    return this.isSignIn ? 'Sign up' : 'Sign in'
  }
  async submit() {
    this.errors = new User()
    const service = new AuthService()
    let resp: Response
    if (this.isSignIn) {
      resp = await service.login({
        username: this.user.username,
        password: this.user.password,
      })
    } else {
      resp = await service.createUser({
        username: this.user.username,
        email: this.user.email,
        password: this.user.password,
      })
    }
    try {
      const data = await resp.json()

      if (resp.ok) {
        const token = (data as User).token
        localStorage.setItem(Constants.token, createToken(token))
        const routeParams = this.$route.params
        if ('nextUrl' in routeParams && routeParams.nextUrl) {
          this.$router.push(this.$route.params.nextUrl)
        } else {
          this.$router.push(RoutesPaths.home)
        }
      } else {
        Vue.set(this, 'errors', data ?? new User(resp.statusText))
      }
    } catch (error) {
      Vue.set(this, 'errors', new User(resp.statusText))
    }
  }
}
</script>
