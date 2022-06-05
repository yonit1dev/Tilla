import * as express from 'express'
import TokenService from '../services/TokenService'
import '../usecase/signinUseCase'
import LoginUseCase from '../usecase/signinUseCase'
import RegisterUseCase from '../usecase/signupUseCase'

export default class AuthenticationController{

    private readonly signinUseCase: LoginUseCase
    private readonly signupUseCase: RegisterUseCase
    private readonly jwtService: TokenService

    constructor(
        signinUseCase: LoginUseCase,
        signupUseCase: RegisterUseCase,
        jwtService: TokenService,)
        {
        this.signinUseCase = signinUseCase
        this.signupUseCase = signupUseCase
        this.jwtService = jwtService
    }

    public async login(req: express.Request, res :express.Response){
        try{
            const {username, password} = req.body
            return this.signinUseCase.execute(username, password).then((id: string) => res.status(200).json({
                auth_token: this.jwtService.encode(id), 
            })).catch((err: Error) => res.status(404).json({error: err}))
        }
        catch(err){
            return res.status(400).json({error: err})
        }
    }

    public async register(req: express.Request, res: express.Response){
        try{
            const {firstName, lastName, username, password, authLevel} = req.body

            return this.signupUseCase.execute(firstName, lastName, username, password, authLevel).then((id: string) => res.status(200).json({ auth_token: this.jwtService.encode(id)})).catch((err: Error) => res.status(404).json({ error: err}))
        }catch(err){
            return res.status(400).json({ error: err})
        }
    }
}