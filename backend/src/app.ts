import express from 'express'
import dotenv from 'dotenv'
import DBConnect from './composeRt'

dotenv.config()
DBConnect.config()

const PORT = process.env.PORT
const app = express()

app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.use('/authentication', DBConnect.authRouter())
app.use('/transactions', DBConnect.transactionRouter())
app.use('/budgets', DBConnect.budgetRouter())

app.listen(PORT, () => console.log('Running on port '+ PORT))