export default class Transaction{
    constructor(
        public readonly id: string,
        public readonly date: string,
        public readonly accountID: string,
        public readonly type: string,
        public readonly amount: number,
        public readonly description: string,
        public readonly categoryID: string,
    ){}
}