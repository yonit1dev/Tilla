import mongoose from "mongoose";
import pagination from "mongoose-paginate-v2"

export interface TransactionDoc extends mongoose.Document{
    date: string,
    accountID: string,
    type: string,
    amount: number,
    description: string,
    categoryID: string
}

export interface TransactionModel extends mongoose.PaginateModel<TransactionDoc>{}

const TransactionSchema = new mongoose.Schema({
    date: {type: String, required: true},
    accountID: {type: String, required: true},
    type: {type: String, required: true},
    amount: {type: Number, required: true},
    description: {type: String},
    categoryID: {type: String}
})

TransactionSchema.plugin(pagination)
export default TransactionSchema