const URL = 'https://trello.backend.tests.nekidaem.ru/api/v1/'

export const api = {
  users: {
    create: `${URL}users/create/`,
    login: `${URL}users/login/`,
    refreshToken: `${URL}users/refresh_token/`,
  },
  cards: `${URL}cards/`,
}
