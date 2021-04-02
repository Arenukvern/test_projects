<template lang="pug">
mixin auth-screen
  transition-group(:name="'fade-group'" tag='div')
    sign-in.fade-group-item(
      key='signin' v-if='isSignIn'
      :email='email'
    )
    sign-up.fade-group-item(
      key='signup' v-if='isSignUp'
      @openSignIn='openSignInWithUser'
    )
div(
  :class='classes'
  v-if='isSmall'
)
  .column.center
    .column.h-18.w-14
      +auth-screen
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
div(
  :class='classes'
  v-if='isMedium || isLarge'
)
  .column.center
    .column.h-21.w-14.main-align-space-between
      +auth-screen
      .row.cross-align-end
        tab.border-radius-9.mr-6(
          :isActive='isSignIn'
          @click='enableSignIn'
          
        ) 
          .subtitle Sign in
        tab.border-radius-9(
          :isActive='isSignUp'
          @click='enableSignUp'
          
        )
          .subtitle Sign up

</template>

<script lang="ts">
  import { User } from '#/abstract'
  import { useScreenSize } from '#/composable'
  import { computed, defineAsyncComponent, defineComponent, ref } from 'vue'
  enum Mode {
    signin,
    signup,
  }
  const coreClasses = 'grid z-10 columns-1  h-full relative'
  export default defineComponent({
    name: 'Auth',
    components: {
      SignIn: defineAsyncComponent(() => import('./sign-in.vue')),
      SignUp: defineAsyncComponent(() => import('./sign-up.vue')),
      Tab: defineAsyncComponent(() => import('#/components-core/tab.vue')),
    },
    setup() {
      const { isSmall, isMedium, isLarge } = useScreenSize()
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
      const classes = computed(() => {
        return [isSmall ? 'rows-90p' : '', coreClasses].join(' ')
      })
      return {
        email,
        openSignInWithUser,
        isSignIn,
        isSignUp,
        enableSignIn,
        enableSignUp,
        isSmall,
        isMedium,
        isLarge,
        classes,
      }
    },
  })
</script>
