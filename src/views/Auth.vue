<template lang="pug">
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
export class AuthView extends Vue {}
</script>
