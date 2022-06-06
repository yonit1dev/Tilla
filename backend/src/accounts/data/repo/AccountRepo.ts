import { Mongoose, PaginateResult } from "mongoose";
import Pageable from "../../domain/Pageable";
import Account from "../../domain/Account";
import IAccountRepo from "../../domain/IAccountRepo";
import AccountSchema, { AccountDoc, AccountModel } from "../model/AccountModel";

export default class AccountRepo implements IAccountRepo{

    constructor(private readonly client: Mongoose){}
    async delete(id: string): Promise<string> {
        const model = this.client.model<AccountDoc>('Accounts', AccountSchema) as AccountModel

        const deleted = await model.findById(id)

        if(deleted){
            model.deleteOne({id: id})
            return Promise.resolve("Deleted Successfully")
        }

        return Promise.reject("Account not found")

        
    }
    async update(account: Account): Promise<void> {
        const model = this.client.model<AccountDoc>('Accounts', AccountSchema) as AccountModel

        let index = await model.findById(account.id)

        if (index){
            model.updateOne({"_id": account.id}, {$set: {
                "bankName" : account.bankName,
                "balance" : account.balance,
                "type" : account.type,
                "assocCard" : account.assocCard,
                "assocCardExp" : account.assocCardExp,
            }})
        }
    }
    
    async add(bankName: string, balance: number, type: string, assocCard: string, assocCardExp: string): Promise<string> {
        const model = this.client.model<AccountDoc>('Accounts', AccountSchema) as AccountModel

        const added = await model.create({
            bankName: bankName,
            balance: balance,
            type: type,
            assocCard: assocCard,
            assocCardExp: assocCardExp
        })

        await added.save()

        return added.id
    }

    async findAll(page: number, pageSize: number): Promise<Pageable<Account>> {
        const allAccounts = this.client.model<AccountDoc>('Accounts', AccountSchema) as AccountModel

        const pageOptions = {page: page, limit: pageSize}
        
        const pageResults = await allAccounts.paginate({}, pageOptions).catch((_) => null)

        return this.accountFromPageResults(pageResults)
    }
    
    private accountFromPageResults(pageResults: PaginateResult<AccountDoc> | null){
        if (pageResults == null || pageResults.docs.length === 0) return Promise.reject("No Accounts")

        const result = pageResults.docs.map<Account>((model) => new Account(
            model.id,
            model.bankName,
            model.balance,
            model.type,
            model.assocCard,
            model.assocCardExp
        ))

        return new Pageable<Account>(
            pageResults.page ?? 0,
            pageResults.limit,
            pageResults.totalPages,
            result
        )
    }
    
}