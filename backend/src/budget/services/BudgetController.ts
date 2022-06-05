import express from "express"
import IBudgetRepo from "../domain/IBudgetRepo";


export default class BudgetController{
    constructor(private readonly repo: IBudgetRepo){}

    public async add(req: express.Request, res: express.Response){
        try{
            const {type, accountID, utilized, goalAmount, endDate, description} = req.body

            return this.repo.add(type, accountID, utilized, goalAmount, endDate, description).then((_) => res.status(200).json("Budget added successfully")).catch((err: Error) => res.status(404).json({error: err}))
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
                budgets: pageable.data
            })).catch((err: Error) => res.status(404).json({error: err}))

        }catch(err){
            return res.status(400).json({ error: err })
        }
    }
}