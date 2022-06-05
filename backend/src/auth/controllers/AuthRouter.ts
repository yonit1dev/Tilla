import * as express from 'express'
import TAuthRepository from '../domain/TAuthRepository';
import { loginValidation, registerValidation, validate } from '../middleware/Validators';
import PasswordService from '../services/password';
import TokenService from '../services/TokenService';
import LoginUseCase from '../usecase/signinUseCase';
import RegisterUseCase from '../usecase/signupUseCase';
import AuthenticationController from './AuthController';

export default class AuthenticationRouter{
    public static configure(
        authRepository: TAuthRepository, 
        tokenServ: TokenService,
        passwordService: PasswordService): express.Router{

        const router = express.Router()

        let contr = AuthenticationRouter.composeContr(
            authRepository, 
            tokenServ, 
            passwordService)

        router.post('/login', loginValidation(), validate, (req: express.Request, res: express.Response) => contr.login(req, res))

        router.post('/signup', registerValidation(), validate,(req: express.Request, res: express.Response) => contr.register(req, res))

        return router
    }

    private static composeContr(
        authRepository: TAuthRepository, 
        tokenService: TokenService,
        passwordService: PasswordService): AuthenticationController {

            const loginUseCase = new LoginUseCase(authRepository, passwordService)
            const signupUseCase = new RegisterUseCase(authRepository, passwordService)

            const contr = new AuthenticationController(
                 loginUseCase,
                 signupUseCase,
                 tokenService  
            )

            return contr
        }
}