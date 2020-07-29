<template lang="pug">
.card
  .card__title.--has-text-centered.--has-text-accent {{title}}
  .card__body 
    .column
      v-input(v-model='user.username' :errors='errors.username')
      v-input(v-model='user.email' :errors='errors.email')
      v-input(v-model='user.password' :errors='errors.password')
  .card__actions
    v-btn(@click='submit') {{actionBtnTitle}}
</template>
<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'
import { StatelessComponentsRouter } from '../componentsRouter'
import { User } from '../entities/User'
import { AuthService } from '@/services/AuthService'
import { Constants } from '../constants/Constants'
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
  get isUserExists() {
    return false
  }
  get title() {
    return this.isUserExists ? 'Авторизация' : 'Регистрация'
  }
  get actionBtnTitle() {
    return this.isUserExists ? 'Войти' : 'Зарегистрироваться'
  }
  errors: User = new User()
  async submit() {
    this.errors = new User()
    const service = new AuthService()
    let resp: Response
    if (this.isUserExists) {
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
    const data = await resp.json()
    if (resp.ok) {
      localStorage.setItem(Constants.token, (data as User).token)
    } else {
      this.errors = data
    }
  }
}
</script>
