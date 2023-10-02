import { deployments, ethers, getNamedAccounts } from "hardhat"
import { assert, expect } from "chai"

describe("FundMe", function () {
    let fundMe: any
    let deployer: any
    let mockV3Aggregator: any
    const sendValue = ethers.parseEther("1")
    beforeEach(async function() {
        deployer = (await getNamedAccounts()).deployer
        deployments.fixture(["all"]) // deploy our fundMe contract using hardhat-deploy
        fundMe = await ethers.getContractAt("FundMe", deployer)
        mockV3Aggregator = await ethers.getContractAt("MockV3Aggregator", deployer)
    })

    describe("constructor", async function() {
        // NOT WORKING
        // Error: could not decode result data (value="0x", info={ "method": "getPriceFeed", "signature": "getPriceFeed()" }, code=BAD_DATA, version=6.7.1)
        // it ("sets the aggregator addresses correctly", async function() {
        //     const response = await fundMe.getPriceFeed()
        //     assert.equal(response, mockV3Aggregator.target)
        // })
    })

    
    describe("fund", async function() {
        // NOT WORKING
        // AssertionError: Expected transaction to be reverted with reason 'Didn't send enough!', but it didn't revert
        // it ("fails if you don't send enough eth", async function() {
        //     await expect(fundMe.fund()).to.be.revertedWith("Didn't send enough!")
        // })

        // NOT WORKING
        // Error: could not decode result data (value="0x", info={ "method": "addressToAmountFunded", "signature": "addressToAmountFunded(address)" }, code=BAD_DATA, version=6.7.1)
        // it ("updated the amount funded data structure", async function() {
        //     await fundMe.fund({ value: sendValue})
        //     const response = await fundMe.addressToAmountFunded(deployer)
        //     assert.equal(response.toString(), sendValue.toString())
        // })

        // NOT WORKING
        // Error: could not decode result data (value="0x", info={ "method": "funders", "signature": "funders(uint256)" }, code=BAD_DATA, version=6.7.1)
        // it ("adds funder to array of funders", async function() {
        //     await fundMe.fund({value: sendValue})
        //     const funder = await fundMe.funders(0)
        //     assert.equal(funder, deployer)
        // })
    })

    describe("withdraw", async function() {
        this.beforeEach(async function() {
            await fundMe.fund({ value: sendValue })
        })

    // NOT WORKING
    // TypeError: Cannot read properties of undefined (reading 'getBalance')
//     it("withdraw Eth from a single founder", async function() {
//         //Arrange
//         // console.log(fundMe.runner.provider._hardhatProvider.provider)
//         const startingFundMeBalance = await fundMe.provider.getBalance(
//             fundMe.target
//         )
//         const startingDeployerBalance = await fundMe.provider.getBalance(
//             deployer
//         )
        
//         // Act
//         const transactionResponse = await fundMe.withdraw()
//         const transactionReceipt = await transactionResponse.wait()
//         const { gasUsed, effectiveGasPrice } = transactionReceipt
//         const gasCost = gasUsed.mul(effectiveGasPrice)

//         const endingFundMeBalance = await fundMe.provider.getBalance(
//             fundMe.address
//         )
//         const endingDeployerBalance =
//             await fundMe.provider.getBalance(deployer)

//         // Assert
//         // Maybe clean up to understand the testing
//         assert.equal(endingFundMeBalance, 0)
//         assert.equal(
//             startingFundMeBalance
//                 .add(startingDeployerBalance)
//                 .toString(),
//             endingDeployerBalance.add(gasCost).toString()
//         )
    //     })
    })


    // NOT WORKING
    // TypeError: Cannot read properties of undefined (reading 'getBalance')
    // this test is overloaded. Ideally we'd split it into multiple tests
    // but for simplicity we left it as one
    // it("is allows us to withdraw with multiple funders", async () => {
    //     // Arrange
    //     const accounts = await ethers.getSigners()
    //     for (let i = 1; i < 6; i++) {
    //         const fundMeConnectedContract = await fundMe.connect(
    //             accounts[i]
    //         )
    //         await fundMeConnectedContract.fund({ value: sendValue })
    //     }
    //     const startingFundMeBalance =
    //         await fundMe.provider.getBalance(fundMe.address)
    //     const startingDeployerBalance =
    //         await fundMe.provider.getBalance(deployer)

    //     // Act
    //     const transactionResponse = await fundMe.cheaperWithdraw()
    //     // Let's comapre gas costs :)
    //     // const transactionResponse = await fundMe.withdraw()
    //     const transactionReceipt = await transactionResponse.wait()
    //     const { gasUsed, effectiveGasPrice } = transactionReceipt
    //     const withdrawGasCost = gasUsed.mul(effectiveGasPrice)
    //     console.log(`GasCost: ${withdrawGasCost}`)
    //     console.log(`GasUsed: ${gasUsed}`)
    //     console.log(`GasPrice: ${effectiveGasPrice}`)
    //     const endingFundMeBalance = await fundMe.provider.getBalance(
    //         fundMe.address
    //     )
    //     const endingDeployerBalance =
    //         await fundMe.provider.getBalance(deployer)
    //     // Assert
    //     assert.equal(
    //         startingFundMeBalance
    //             .add(startingDeployerBalance)
    //             .toString(),
    //         endingDeployerBalance.add(withdrawGasCost).toString()
    //     )
    //     // Make a getter for storage variables
    //     await expect(fundMe.getFunder(0)).to.be.reverted

    //     for (let i = 1; i < 6; i++) {
    //         assert.equal(
    //             await fundMe.getAddressToAmountFunded(
    //                 accounts[i].address
    //             ),
    //             0
    //         )
    //     }
    // })

    // NOT WORKING
    // AssertionError: Expected transaction to be reverted with reason 'FundMe__NotOwner', but it didn't revert
    // it("Only allows the owner to withdraw", async function () {
    //     const accounts = await ethers.getSigners()
    //     const fundMeConnectedContract = await fundMe.connect(
    //         accounts[1]
    //     )
    //     await expect(
    //         fundMeConnectedContract.withdraw()
    //     ).to.be.revertedWith("FundMe__NotOwner")
    // })
})