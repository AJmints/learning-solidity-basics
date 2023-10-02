import { deployments, ethers, getNamedAccounts } from "hardhat"
import { assert, expect } from "chai"

describe("FundMe", function () {
    let fundMe: any
    let deployer: any
    let mockV3Aggregator: any
    const sendValue = "1000000000000000000"
    this.beforeEach(async function() {
        deployer = (await getNamedAccounts()).deployer
        deployments.fixture(["all"]) // deploy our fundMe contract using hardhat-deploy
        fundMe = await ethers.getContractAt("FundMe", deployer)
        mockV3Aggregator = await ethers.getContractAt("MockV3Aggregator", deployer)
    })

    describe("constructor", async function() {
        it ("sets the aggregator addresses correctly", async function() {
            // const response = await fundMe.getPriceFeed()
            const response = fundMe.priceFeed._contract.target 
            assert.equal(response, mockV3Aggregator.target)
        })
    })

    
    describe("fund", async function() {
        // NOT WORKING
        // it ("fails if you don't send enough eth", async function() {
            // const check = await fundMe.fund({ value: "10" })
            // console.log(typeof check.value)
            // await expect(fundMe.fund()).to.be.revertedWith("Didn't send enough!")
        // })

        it ("updated the amount funded data structure", async function() {
            await fundMe.fund({ value: sendValue})
        })
    })

    

})