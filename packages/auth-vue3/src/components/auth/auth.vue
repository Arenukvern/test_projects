<template lang="pug">
.grid.columns-1.rows-90p.h-full.relative.z-10
  .column.center
    .column.h-18.w-14
      transition-group(name="fade-group" tag='div')
        sign-in.fade-group-item(
          key='signin' v-if='isSignIn'
          :email='email'
        )
        sign-up.fade-group-item(
          key='signup' v-if='isSignUp'
          @openSignIn='openSignInWithUser'
        )
  .row.cross-align-end
    tab(
      :isActive='isSignIn'
      @click='enableSignIn'
      position='left'
    ) Sign in
    tab(
      :isActive='isSignUp'
      @click='enableSignUp'
      position='right'
    ) Sign up
</template>

<script lang="ts">
  import { User } from '#/abstract'
  import { computed, defineAsyncComponent, defineComponent, ref } from 'vue'
  enum Mode {
    signin,
    signup,
  }
  export default defineComponent({
    name: 'Auth',
    components: {
      SignIn: defineAsyncComponent(() => import('./sign-in.vue')),
      SignUp: defineAsyncComponent(() => import('./sign-up.vue')),
      Tab: defineAsyncComponent(() => import('#/components-core/tab.vue')),
    },
    setup() {
      // =============== Mods ================
      const currentMode = ref(Mode.signin)
      const isSignIn = computed(() => currentMode.value === Mode.signin)
      const isSignUp = computed(() => currentMode.value === Mode.signup)
      const enableSignIn = () => {
        currentMode.value = Mode.signin
      }
      const enableSignUp = () => (currentMode.value = Mode.signup)
      const email = ref<string>('')
      const openSignInWithUser = (newUser: User) => {
        email.value = newUser.email
        enableSignIn()
      }
      return {
        email,
        openSignInWithUser,
        isSignIn,
        isSignUp,
        enableSignIn,
        enableSignUp,
      }
    },
  })
</script>
