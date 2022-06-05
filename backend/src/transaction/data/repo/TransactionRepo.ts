import { Mongoose, PaginateResult } from "mongoose";
import { isDataView } from "util/types";
import ITransactionRepo from "../../domain/ITransactionRepo";
import Pageable from "../../domain/Pageable";
import Transaction from "../../domain/Transaction";
import TransactionSchema, { TransactionDoc, TransactionModel } from "../model/Transaction";

export default class TransactionRepo implements ITransactionRepo{

    constructor(private readonly client: Mongoose){}
    async delete(id: string): Promise<string> {
        const model = this.client.model<TransactionDoc>('Transactions', TransactionSchema) as TransactionModel

        const deleted = await model.findById(id)

        if(deleted){
            model.deleteOne({id: id})
            return Promise.resolve("Deleted Successfully")
        }

        return Promise.reject("Record not found")

        
    }
    async update(transaction: Transaction): Promise<void> {
        const model = this.client.model<TransactionDoc>('Transactions', TransactionSchema) as TransactionModel

        let index = await model.findById(transaction.id)

        if (index){
            model.updateOne({"_id": transaction.id}, {$set: {
                "accountID" : transaction.accountID,
                "date" : transaction.date,
                "amount" : transaction.amount,
                "description" : transaction.description,
                "type" : transaction.type,
                "categoryID" : transaction.categoryID
            }})
        }
    }
    
    async add(date: string, accountID: string, type: string, amount: number, description: string, categoryID: string): Promise<string> {
        const model = this.client.model<TransactionDoc>('Transactions', TransactionSchema) as TransactionModel

        const added = await model.create({
            date: date,
            accountID: accountID,
            type: type,
            amount: amount,
            description: description,
            categoryID: categoryID
        })

        await added.save()

        return added.id
    }

    async findAll(page: number, pageSize: number): Promise<Pageable<Transaction>> {
        const allTransactions = this.client.model<TransactionDoc>('Transactions', TransactionSchema) as TransactionModel

        const pageOptions = {page: page, limit: pageSize}
        
        const pageResults = await allTransactions.paginate({}, pageOptions).catch((_) => null)

        return this.transactionsFromPageResults(pageResults)
    }
    async findByDate(date: string, page: number, pageSize: number): Promise<Pageable<Transaction>> {
        const allTransactions = this.client.model<TransactionDoc>('Transactions', TransactionSchema) as TransactionModel

        const pageOptions = {page: page, limit: pageSize}
        
        const pageResults = await allTransactions.paginate({date: date}, pageOptions).catch((_) => null)

        return this.transactionsFromPageResults(pageResults)
    }

    private transactionsFromPageResults(pageResults: PaginateResult<TransactionDoc> | null){
        if (pageResults == null || pageResults.docs.length === 0) return Promise.reject("No Transactions")

        const result = pageResults.docs.map<Transaction>((model) => new Transaction(
            model.id,
            model.date,
            model.accountID,
            model.type,
            model.amount,
            model.description,
            model.categoryID
        ))

        return new Pageable<Transaction>(
            pageResults.page ?? 0,
            pageResults.limit,
            pageResults.totalPages,
            result
        )
    }
    
}