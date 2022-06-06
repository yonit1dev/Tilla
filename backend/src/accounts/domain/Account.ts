export default class Account{
    constructor(
        public readonly id: string,
        public readonly bankName: string,
        public readonly balance: number,
        public readonly type: string,
        public readonly assocCard: string,
        public readonly assocCardExp: string,

    ){}
}