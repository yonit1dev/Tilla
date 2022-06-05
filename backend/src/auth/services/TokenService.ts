export default interface TokenService{
    encode(payload: string | object): string | object

    decode(token: string | object): string | object
}