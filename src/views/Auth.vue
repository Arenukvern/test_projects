<template lang="pug">
.column
  login-logout
</template>

<script lang="ts">
import { Vue, Component } from 'vue-property-decorator'
import { ComponentsRouter } from '@/componentsRouter'
const LoginLogout = ComponentsRouter.LoginLogout
@Component({
  components: {
    LoginLogout,
  },
})
export default class AuthView extends Vue {}
</script>
