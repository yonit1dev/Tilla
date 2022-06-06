import express from "express"
import IAccountRepo from "../domain/IAccountRepo";


export default class AccountController{
    constructor(private readonly repo: IAccountRepo){}

    public async add(req: express.Request, res: express.Response){
        try{
            const {bankName, balance, type, assocCard, assocCardExp} = req.body

            return this.repo.add(bankName, balance, type, assocCard, assocCardExp).then((_) => res.status(200).json("Account added successfully")).catch((err: Error) => res.status(404).json({error: err}))
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
                accounts: pageable.data
            })).catch((err: Error) => res.status(404).json({error: err}))

        }catch(err){
            return res.status(400).json({ error: err })
        }
    }
}