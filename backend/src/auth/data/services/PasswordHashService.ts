import bcrypt from 'bcrypt'

import PasswordService from "../../services/password";

export default class PasswordHashService implements PasswordService{

    constructor(private readonly saltRounds: number = 10){}

    hash(password: string): Promise<string> {
        return bcrypt.hash(password, this.saltRounds)
    }
    compare(password: string, hashed: string): Promise<boolean> {
        return bcrypt.compare(password, hashed)
    }
}