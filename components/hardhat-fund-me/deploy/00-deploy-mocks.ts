import { network } from "hardhat"
const { developmentChains, DECIMALS, INITIAL_ANSWER  } = require("../helper-hardhat-config")

module.exports = async ({ getNamedAccounts, deployments}: any) => {
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts() 
    const chainId: any = network.config.chainId

    if (developmentChains.includes(network.name)) {
        log("Local network detected! Deploying mocks...")
        /* When setting up our mock contract, we will need to reference the actual contract we are setting our mock up from
        -in our case, we are using V3Aggregator from Chainlink so we can use this contract to get pricefeeds for our testing deployments
        -we can find the mock contract that has been made by Chainlink by going to the node_modules where it is located, then we follow...
        node_modules/@chainlink/contracts/src/v0.6/tests/MockV3Aggregator.sol 
        -now we can check the constructor to find the arguments the contract needs to be instantiated and use that to populate our 
        deploy function args array
        -we defined DECIMALS and INITIAL_ANSWER in our helper-hardhat-config */
        await deploy("MockV3Aggregator", {
            contract: "MockV3Aggregator",
            from: deployer,
            log: true,
            args: [DECIMALS, INITIAL_ANSWER]
        })
        log("Mocks deployed!")
        log("-----------------------------------------------------------")
    }
}

module.exports.tags = ["all", "mocks"]