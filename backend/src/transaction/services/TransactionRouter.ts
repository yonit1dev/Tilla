import express from "express"
import ITransactionRepo from "../domain/ITransactionRepo";
import TransactionController from "./TransactionController";

export default class TransactionRouter{
    public static config(repo: ITransactionRepo): express.Router{
        const router = express.Router()

        let controller = new TransactionController(repo)

        router.get('/', (req, res) => controller.findAll(req, res))

        router.get('/date', (req, res) => controller.findByDate(req, res))

        router.post('/add', (req, res) => controller.add(req, res))

        return router
    }
}