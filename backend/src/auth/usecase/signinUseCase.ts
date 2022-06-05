import TAuthRepository from "../domain/TAuthRepository";
import User from "../domain/user";
import PasswordService from "../services/password";

export default class LoginUseCase{
    constructor(private authRepository: TAuthRepository, private passwordService: PasswordService){}

    public async execute(username: string, password: string): Promise<string>{
        
        return this.nativeLogin(username, password)

    }

    public async executeFind(username: string): Promise<User>{
        return this.findUser(username);
    }

    private async findUser(username: string){
        const user = await this.authRepository.find(username).catch((_) => null);

        if(!user) {return Promise.reject('Error')}

        return user
    }

    private async nativeLogin(username: string, password: string){
        
        const user = await this.authRepository.find(username).catch((_) => null)

        if ((!user ) || (!(await this.passwordService.compare(password, user.password)))){
            return Promise.reject('Incorrect email or password')
        }

        return user.id
    }
}