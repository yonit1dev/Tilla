import User from './user'

export default interface TAuthRepository{
    find(username: string) : Promise<User>
    add(
        firstName: string,
        lastName: string,
        username: string,
        passwordHashed: string,
        authLevel: string
    ): Promise<string>
}