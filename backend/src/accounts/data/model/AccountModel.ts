import mongoose from "mongoose";
import pagination from "mongoose-paginate-v2"

export interface AccountDoc extends mongoose.Document{
    bankName: string,
    balance: number,
    type: string,
    assocCard: string,
    assocCardExp: string,
}

export interface AccountModel extends mongoose.PaginateModel<AccountDoc>{}

const AccountSchema = new mongoose.Schema({
    bankName: {type: String, required: true},
    balance: {type: Number, required: true},
    type: {type: String, required: true},
    assocCard: {type: String},
    assocCardExp: {type: String},
})

AccountSchema.plugin(pagination)
export default AccountSchema