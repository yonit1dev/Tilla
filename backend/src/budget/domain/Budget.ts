export default class Budget{
    constructor(
        public readonly id: string,
        public readonly type: string,
        public readonly accountID: string,
        public readonly utilized: number,
        public readonly goalAmount: number,
        public readonly endDate: string,
        public readonly description: string,
    ){}
}