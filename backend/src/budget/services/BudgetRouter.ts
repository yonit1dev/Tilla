import express from "express"
import IBudgetRepo from "../domain/IBudgetRepo";
import ITransactionRepo from "../domain/IBudgetRepo";
import BudgetController from "./BudgetController";

export default class BudgetRouter{
    public static config(repo: IBudgetRepo): express.Router{
        const router = express.Router()

        let controller = new BudgetController(repo)

        router.get('/', (req, res) => controller.findAll(req, res))

        router.post('/add', (req, res) => controller.add(req, res))

        return router
    }
}