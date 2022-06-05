// import { NextFunction, Request, Response } from "express";
// import TokenSave from "../services/TokenSave";
// import TokenService from "../services/TokenService";


// export default class ValidatorToken{
//     constructor(
//         private readonly tokenServ: TokenService,
//         private readonly tokenSave: TokenSave
//     ){}

//     public async validate(req: Request, res: Response, next: NextFunction){

//         const authenticationHeader = req.headers.authorization

//         if(!authenticationHeader) return res.status(401).json({error: 'Authorization header required'})

//         if(
//             this.tokenServ.decode(authenticationHeader) === '' || (await this.tokenSave.get(authenticationHeader)) != ''
//         ) return res.status(403).json({ error: 'Corrupted Token'})

//         next()
//     }
// }