import Pageable from "./Pageable";
import Transaction from "./Transaction";

export default interface ITransactionRepo{

    add(
        date: string,
        accountID: string,
        type: string,
        amount: number,
        description: string,
        categoryID: string
    ): Promise<string>

    update(transaction: Transaction): Promise<void>

    delete(id: string): Promise<string>
 
    findAll(page: number, pageSize: number): Promise<Pageable<Transaction>>
    
    findByDate(date: string, page: number, pageSize: number): Promise<Pageable<Transaction>>

}