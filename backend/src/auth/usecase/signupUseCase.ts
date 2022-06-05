import TAuthRepository from "../domain/TAuthRepository";
import PasswordService from "../services/password";

export default class RegisterUseCase{

    constructor(
        private authRepository: TAuthRepository,
        private passwordService: PasswordService
    ){}

    public async execute(
        firstName: string,
        lastName: string,
        username: string,
        password: string,
        authLevel: string
    ): Promise<string>{
        const user = await this.authRepository.find(username).catch((_) => null)
        if (user) return Promise.reject('Username taken')

        let passwordhashed

        if(password){
            passwordhashed = await this.passwordService.hash(password)
        }
        else{
            passwordhashed = ''
        }

        const userID = await this.authRepository.add(
            firstName,
            lastName,
            username,
            passwordhashed,
            authLevel,
        )

        return userID
    }
}