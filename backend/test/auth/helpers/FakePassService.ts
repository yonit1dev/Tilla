import PasswordService from "../../../src/auth/services/password";

export default class FakePassService implements PasswordService{
    public async hash(password: string): Promise<string>{
        return password
    }
    public async compare(password: string, hashed: string): Promise<boolean>{
        return password == hashed
    }
}