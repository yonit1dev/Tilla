import { Mongoose } from "mongoose";
import TAuthRepository from "../../domain/TAuthRepository";
import User from "../../domain/user";
import { UserModel, UserSchema } from "../models/UserModel";


export default class AuthRepository implements TAuthRepository{
    constructor(private readonly client: Mongoose){}

    public async find(username: string): Promise<User> {
        const allUsers = this.client.model<UserModel>('User', UserSchema)

        const user = await allUsers.findOne({username: username})

        if(!user) return Promise.reject('User not found')

        return new User(
            user.id, user.firstName, user.lastName, user.username, user.password, user.authLevel
        )
    }

    public async add(firstName: string, lastName: string, username: string, passwordHashed: string, authLevel: string): Promise<string> {

         const userModel = this.client.model<UserModel>('User', UserSchema)

        const addedUser = await userModel.create({
            firstName: firstName,
            lastName: lastName,
            username: username.toLowerCase(),
            authLevel: authLevel,
        })

        if (passwordHashed){
            addedUser.password = passwordHashed
        }

        await addedUser.save()

        return addedUser.id
    }

}