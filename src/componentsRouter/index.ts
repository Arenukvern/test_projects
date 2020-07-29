export const ComponentsRouter = {
  Board: (): any => import('@/components/Board.vue'),
  BoardColumn: (): any => import('@/components/BoardColumn.vue'),
  BoardCard: (): any => import('@/components/BoardCard.vue'),
  LoginLogout: (): any => import('@/components/LoginLogout.vue'),
  AppToolbar: (): any => import('@/components/AppToolbar.vue'),
}

export const StatelessComponentsRouter = {
  VToolbar: (): any => import('@/components/Stateless/VToolbar.vue'),
  VIcon: (): any => import('@/components/Stateless/VIcon.vue'),
  VBtn: (): any => import('@/components/Stateless/VBtn.vue'),
  VInput: (): any => import('@/components/Stateless/VInput.vue'),
}
