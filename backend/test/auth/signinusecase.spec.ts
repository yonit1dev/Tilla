import 'mocha'
import chai, {expect } from 'chai'
import chaiAsPromised from 'chai-as-promised'
import LoginUseCase from '../../src/auth/usecase/signinUseCase'
import AuthRepository from '../../src/auth/domain/TAuthRepository'
import PasswordService from '../../src/auth/services/password'
import DummyRepository from './helpers/DummyRepository'
import FakePassService from './helpers/FakePassService'

chai.use(chaiAsPromised)

describe('SignInUseCase', () => {
    let sut: LoginUseCase
    let repository: AuthRepository
    let passwordService: PasswordService

    const user = {
        username: 'user1@email.com',
        id: '011',
        firstName: 'First',
        lastName: 'User',
        password: 'sfnewoi3@rnwo3$1e@Ensendfw#',
        authType: 'native'
    }

    beforeEach(() => {
        repository = new DummyRepository(),
        passwordService = new FakePassService(),
        sut = new LoginUseCase(repository, passwordService)

    })

    it('Error if user not found', async () => {
        const user = {username: 'testemail@email.com', password: 'testpass'}

        await expect(sut.execute(user.username, user.password)).to.be.rejectedWith('User not found')
    })

    it('User id returned when authenticated',async () => {
        const id = await sut.execute(user.username, user.password)

        expect(id).to.be.equal(user.id)
    })


})