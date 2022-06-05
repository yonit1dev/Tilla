import * as mongoose from 'mongoose'

export interface UserModel extends mongoose.Document{
    firstName: string,
    lastName: string,
    username: string,
    password: string,
    authLevel: string
}

export const UserSchema = new mongoose.Schema({
    firstName: {type: String, default: "User"},
    lastName: {type: String, default: "User"},
    username: {type: String, required: true},
    password: {type: String},
    authLevel: {type: String, required: true}
});