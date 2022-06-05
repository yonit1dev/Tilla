import { Mongoose, PaginateResult } from "mongoose";
import Pageable from "../../domain/Pageable";
import Transaction from "../../domain/Budget";
import IBudgetRepo from "../../domain/IBudgetRepo";
import BudgetSchema, { BudgetDoc, BudgetModel } from "../model/Budget";
import Budget from "../../domain/Budget";

export default class BudgetRepo implements IBudgetRepo{

    constructor(private readonly client: Mongoose){}
    async delete(id: string): Promise<string> {
        const model = this.client.model<BudgetDoc>('Budgets', BudgetSchema) as BudgetModel

        const deleted = await model.findById(id)

        if(deleted){
            model.deleteOne({id: id})
            return Promise.resolve("Deleted Successfully")
        }

        return Promise.reject("Budget not found")

        
    }
    async update(budget: Budget): Promise<void> {
        const model = this.client.model<BudgetDoc>('Budgets', BudgetSchema) as BudgetModel

        let index = await model.findById(budget.id)

        if (index){
            model.updateOne({"_id": budget.id}, {$set: {
                "type" : budget.type,
                "accountID" : budget.accountID,
                "utilized" : budget.utilized,
                "goalAmount" : budget.goalAmount,
                "endDate" : budget.endDate,
                "description" : budget.description
            }})
        }
    }
    
    async add(type: string, accountID: string, utilized: number, goalAmount: number, endDate: string, description: string): Promise<string> {
        const model = this.client.model<BudgetDoc>('Budgets', BudgetSchema) as BudgetModel

        const added = await model.create({
            type: type,
            accountID: accountID,
            utilized: utilized,
            goalAmount: goalAmount,
            endDate: endDate,
            description: description
        })

        await added.save()

        return added.id
    }

    async findAll(page: number, pageSize: number): Promise<Pageable<Transaction>> {
        const allBudgets = this.client.model<BudgetDoc>('Budgets', BudgetSchema) as BudgetModel

        const pageOptions = {page: page, limit: pageSize}
        
        const pageResults = await allBudgets.paginate({}, pageOptions).catch((_) => null)

        return this.budgetFromPageResults(pageResults)
    }
    
    private budgetFromPageResults(pageResults: PaginateResult<BudgetDoc> | null){
        if (pageResults == null || pageResults.docs.length === 0) return Promise.reject("No Budgets")

        const result = pageResults.docs.map<Budget>((model) => new Budget(
            model.id,
            model.type,
            model.accountID,
            model.utilized,
            model.goalAmount,
            model.endDate,
            model.description
        ))

        return new Pageable<Budget>(
            pageResults.page ?? 0,
            pageResults.limit,
            pageResults.totalPages,
            result
        )
    }
    
}