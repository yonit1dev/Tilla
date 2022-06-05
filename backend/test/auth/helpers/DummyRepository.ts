import TAuthRepository from "../../../src/auth/domain/TAuthRepository"
import User from "../../../src/auth/domain/user"

export default class DummyRepository implements TAuthRepository {
    public users = [
      {
        id: '011',
        firstName: 'First',
        lastName: 'User',
        username: 'user1@email.com',
        password: 'sfnewoi3@rnwo3$1e@Ensendfw#',
        authType: 'native'
      },
    ]
  
    public async find(username: string): Promise<User> {
      const user = this.users.find((x) => x.username === username)
  
      if (!user) return Promise.reject('User not found')
  
      return new User(
        user?.id,
        user?.firstName,
        user?.lastName,
        user?.username,
        user?.password,
        user?.authType
      )
    }
  
    public async add(
      firstName: string,
      lastName: string,
      username: string,
      password: string,
      authType: string
    ): Promise<string> {
      
      const max = 9999
      const min = 1000
      const id = (Math.floor(Math.random() * (+max - +min)) + +min).toString()
  
      this.users.push({
        username: username,
        id: id,
        firstName: firstName,
        lastName: lastName,
        password: password,
        authType: authType,
      })

      return id
      
    }
  }