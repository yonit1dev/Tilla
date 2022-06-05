export default class User{
    constructor(
        public readonly id: string,
        public readonly firstName: string,
        public readonly lastName: string,
        public readonly username: string,
        public readonly password: string,
        public readonly authType: string,

    ){}
}