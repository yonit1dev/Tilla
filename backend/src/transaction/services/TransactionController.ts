import express from "express"
import ITransactionRepo from "../domain/ITransactionRepo";

export default class TransactionController{
    constructor(private readonly repo: ITransactionRepo){}

    public async add(req: express.Request, res: express.Response){
        try{
            const {date, accountID, type, amount, description, categoryID} = req.body

            return this.repo.add(date, accountID, type, amount, description, categoryID).then((_) => res.status(200).json("Transaction added successfully")).catch((err: Error) => res.status(404).json({error: err}))
        }
        catch(err){
            return res.status(400).json({ error: err })
        }
    }


    public async findAll(req: express.Request, res: express.Response){
        try{
            const {page, limit} = {...req.query} as {page: any; limit: any;}

            return this.repo.findAll(parseInt(page), parseInt(limit)).then((pageable) => res.status(200).json({
                metadata:{
                    page: pageable.page,
                    pageSize: pageable.pageSize,
                    total_pages: pageable.totalPages
                },
                transactions: pageable.data
            })).catch((err: Error) => res.status(404).json({error: err}))

        }catch(err){
            return res.status(400).json({ error: err })
        }
    }

    public async findByDate(req: express.Request, res: express.Response){
        try{
            const { date, page, limit } = req.query as{
                date: string
                page: string,
                limit: string
            }
            return this.repo.findByDate(date, parseInt(page), parseInt(limit)).then((pageable) => res.status(200).json({
                metadata: {
                    page: pageable.page,
                    pageSize: pageable.pageSize,
                    total_pages: pageable.totalPages
                },
                transactions: pageable.data
            })).catch((err: Error) => res.status(404).json({error: err}))
        }catch(err){
            return res.status(400).json({ error: err})
        }
    }
}