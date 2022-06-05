import mongoose from "mongoose";
import pagination from "mongoose-paginate-v2"

export interface BudgetDoc extends mongoose.Document{
    type: string,
    accountID: string,
    goalAmount: number,
    utilized: number,
    endDate: string,
    description: string,

}

export interface BudgetModel extends mongoose.PaginateModel<BudgetDoc>{}

const BudgetSchema = new mongoose.Schema({
    type: {type: String, required: true},
    accountID: {type: String, required: true},
    goalAmount: {type: Number, required: true},
    utilized: {type: String},
    endDate: {type: String, required: true},
    description: {type: String},
})

BudgetSchema.plugin(pagination)
export default BudgetSchema