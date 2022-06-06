import express from "express"
import AccountRepo from "../data/repo/AccountRepo";
import IAccountRepo from "../domain/IAccountRepo";
import AccountController from "./AccountController";

export default class AccountRouter{
    public static config(repo: AccountRepo): express.Router{
        const router = express.Router()

        let controller = new AccountController(repo)

        router.get('/', (req, res) => controller.findAll(req, res))

        router.post('/add', (req, res) => controller.add(req, res))

        return router
    }
}