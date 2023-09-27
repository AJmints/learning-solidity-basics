import { ethers } from "hardhat"
import { expect, assert } from "chai"

describe("SimpleStorage", function () {
    let simpleStorageFactory: any, simpleStorage: any;

    this.beforeEach(async function () {
        simpleStorageFactory = await ethers.getContractFactory(
            "SimpleStorage"
          )
        simpleStorage = await simpleStorageFactory.deploy()
    })

    it("Should start with a favorite number of 0", async function () {
        const currentValue = await simpleStorage.retrieve()
        const expectedValue = "0"

        assert.equal(currentValue.toString(), expectedValue)
        expect(currentValue.toString()).to.equal(expectedValue) // These test are doing the same thing, just showing different methods.
    })

    it("Should update when we call store" , async function() {
        const expectedValue = "7"
        const transactionResponse = await simpleStorage.store(expectedValue)
        await transactionResponse.wait(1)

        const currentValue = await simpleStorage.retrieve()
        assert.equal(currentValue.toString(), expectedValue)
    })

    it("Should add a People object to the peopleList Array", async function() {
        const expectedValue = 2
        let transactionResponse = await simpleStorage.addPerson("Name", 42)
        await transactionResponse.wait(1)
        transactionResponse = await simpleStorage.addPerson("Name2", 42)
        await transactionResponse.wait(1)

        const currentValue = await simpleStorage.viewPeople()
        assert.equal(currentValue, expectedValue)
    })
})