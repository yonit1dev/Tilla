import mongoose from "mongoose";
import AuthenticationRouter from "./auth/controllers/AuthRouter";
import AuthRepository from "./auth/data/repositories/AuthRepository";
import JwtTokenService from "./auth/data/services/JWTokenService";
import PasswordHashService from "./auth/data/services/PasswordHashService";
import BudgetRepo from "./budget/data/repo/BudgetRepo";
import BudgetRouter from "./budget/services/BudgetRouter";
import TransactionRepo from "./transaction/data/repo/TransactionRepo";
import TransactionRouter from "./transaction/services/TransactionRouter";


export default class DBConnect{
    private static client: mongoose.Mongoose

    public static async config(){
        this.client = new mongoose.Mongoose()

        const connectionStr = encodeURI(process.env.DATABASE as string)

        await this.client.connect(connectionStr)
    }

    public static authRouter(){
        const repository = new AuthRepository(this.client)
        const tokenService = new JwtTokenService(process.env.KEY as string)
        const passwordService = new PasswordHashService()
        // const tokenValidator = new ValidatorToken(tokenService, tokenSave)

        return AuthenticationRouter.configure(
            repository,
            tokenService,
            passwordService,
        )

    }

    public static transactionRouter(){
        const repository = new TransactionRepo(this.client)

        return TransactionRouter.config(repository)
    }

    public static budgetRouter(){
        const repository = new BudgetRepo(this.client)

        return BudgetRouter.config(repository)
    }
}