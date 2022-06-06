import Pageable from "./Pageable";
import Account from "./Account";

export default interface IAccountRepo{

    add(
        bankName: string,
        balance: number,
        type: string,
        assocCard: string,
        assocCardExp: string,
    ): Promise<string>

    update(account: Account): Promise<void>

    delete(id: string): Promise<string>
 
    findAll(page: number, pageSize: number): Promise<Pageable<Account>>
    

}