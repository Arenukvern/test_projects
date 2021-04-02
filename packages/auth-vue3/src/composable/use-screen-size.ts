import { onBeforeUnmount, onMounted, ref } from 'vue'

export function useScreenSize() {
  const isSmall = ref(true)
  const isMedium = ref(true)
  const isLarge = ref(true)
  const refresh = () => {
    isSmall.value = window.innerWidth < 640
    isMedium.value = !isSmall.value && window.innerWidth < 1007
    isLarge.value = window.innerWidth > 1007
  }
  const listenLoadAndResize = () => {
    window.addEventListener('load', refresh)
    window.addEventListener('resize', refresh)
  }
  const removeListenLoadAndResize = () => {
    window.removeEventListener('load', refresh)
    window.removeEventListener('resize', refresh)
  }
  onMounted(() => {
    listenLoadAndResize()
    refresh()
  })
  onBeforeUnmount(removeListenLoadAndResize)

  return {
    isSmall,
    isMedium,
    isLarge,
  }
}
