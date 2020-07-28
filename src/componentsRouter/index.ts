export const ComponentsRouter = {
  Card: (): any => import('@/components/Card.vue'),
  Board: (): any => import('@/components/Board.vue'),
  BoardColumn: (): any => import('@/components/BoardColumn.vue'),
  LoginLogout: (): any => import('@/components/LoginLogout.vue'),
}
