import Pageable from "./Pageable";
import Budget from "./Budget";

export default interface IBudgetRepo{

    add(
        type: string,
        accountID: string,
        utilized: number,
        goalAmount: number,
        endDate: string,
        description: string
    ): Promise<string>

    update(budget: Budget): Promise<void>

    delete(id: string): Promise<string>
 
    findAll(page: number, pageSize: number): Promise<Pageable<Budget>>
    

}