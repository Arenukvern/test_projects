import { Maybe, User } from '../abstract'

enum UsersConsts {
  storage = 'users',
}
interface UsersStorageObj {
  [email: string]: Maybe<User>
}
export class UserModel {
  static create({ user }: { user: User }) {
    const usersStorageObj = UserModel.getUsers()
    usersStorageObj[user.email] = user
    UserModel.putUsers({ usersStorageObj })
  }
  static isEmailExists({ email }: { email: User['email'] }) {
    const users = UserModel.getUsers()
    const user = users[email]
    return email === user?.email
  }
  static isPasswordValidForEmail({ user }: { user: User }) {
    const users = UserModel.getUsers()
    const existedUser = users[user.email]
    return existedUser?.password === user.password
  }
  static getUsers(): UsersStorageObj {
    const maybeUsers = localStorage.getItem(UsersConsts.storage)
    if (maybeUsers == null) return {}
    try {
      const usersObjByEmail = JSON.parse(maybeUsers)
      if (typeof usersObjByEmail != 'object') return {}
      return usersObjByEmail
    } catch (error) {
      return {}
    }
  }
  static putUsers({ usersStorageObj }: { usersStorageObj: UsersStorageObj }) {
    const str = JSON.stringify(usersStorageObj)
    localStorage.setItem(UsersConsts.storage, str)
  }
}
