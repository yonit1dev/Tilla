import TokenSave from '../../services/TokenSave';
import { promisify } from 'util';
import {RedisClientType} from 'redis'

export default class RTokenSave implements TokenSave{
    constructor(private readonly client: RedisClientType){}

    save(token: string): void {
        this.client.set(token, token)
    }

    async get(token: string): Promise<string> {
        const getAs = promisify(this.client.get).bind(this.client)
        const res = await getAs(token)

        return res ?? ''
    }
}