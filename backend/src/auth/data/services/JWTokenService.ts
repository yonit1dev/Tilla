import jwt from 'jsonwebtoken'

import TokenService from "../../services/TokenService";

export default class JwtTokenService implements TokenService{

    constructor(private readonly key: string){}

    encode(payload: string | object): string | object {
        let jwtoken = jwt.sign({data: payload}, this.key, {
            issuer: "com.tillaTeam",
            expiresIn: '2h', 
            algorithm: 'HS256'
        })

        return jwtoken
    }
    decode(token: string): string | object {
        try{
            const decoded = jwt.verify(token, this.key)
            return decoded
        }catch(err){
            return 'Invalid jwtoken.'
        }
    }
    
}