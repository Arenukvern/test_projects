export const ComponentsRouter = {
  Card: (): any => import('@/components/Card.vue'),
  Board: (): any => import('@/components/Board.vue'),
  BoardColumn: (): any => import('@/components/BoardColumn.vue'),
  LoginLogout: (): any => import('@/components/LoginLogout.vue'),
}

export const StatelessComponentsRouter = {
  VToolbar: (): any => import('@/components/Stateless/VToolbar.vue'),
  VIcon: (): any => import('@/components/Stateless/VIcon.vue'),
}
