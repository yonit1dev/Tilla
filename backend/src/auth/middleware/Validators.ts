import { NextFunction, Request, Response } from "express";
import { body, validationResult} from 'express-validator'

export const loginValidation = () => {
    return [
        body('username', 'Invalid email').notEmpty().isEmail().normalizeEmail(),
        body('password', 'Password is required (min 8 characters)').if(body('authType').equals('native')).notEmpty().isLength({ min: 8})
    ]
}

export const registerValidation = () => {
    return [
        body('firstName', 'First Name is required').notEmpty(),
        body('lastName', 'Last Name is required').notEmpty(),
        body('username', 'Invalid username').notEmpty().isEmail().normalizeEmail(),
        body('authLevel', 'Auth type is required').notEmpty(),
        body('password', 'Password is required (min 8 characters)').if(body('authType').equals('native')).notEmpty().isLength({ min: 8})
    ]
}

export const validate = (req: Request, res: Response, next: NextFunction) => {
    const errors = validationResult(req)

    if (errors.isEmpty()){
        return next()
    }
    else{
        const extractedErrors: any = []
        errors.array({ onlyFirstError: true }).map((err) => extractedErrors.push({ [err.param]: err.msg}))

        return res.status(422).json({ errors: extractedErrors })
    }
}