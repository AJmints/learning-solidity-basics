import { HardhatRuntimeEnvironment } from "hardhat/types"

const { networkConfig, developmentChains } = require("../helper-hardhat-config")
const { verify } = require("../utils/verify")
/* Same as */
// const helperConfig = require("../helper-hardhat-config")
// const networkConfig = helperConfig.networkConfig


// These 3 setups do the same thing when setting up our module.exports async function

// async function deployFunction(hre:any) {
//     hre.getNamedAccounts()
//     hre.deployments
// }
// module.exports.default = deployFunction

// module.exports = async (hre: any) => {
//     const {getNamedAccounts, deployments} = hre
// }

// module.exports = async ({getNamedAccounts, deployments}: any) => {
// }
module.exports = async (hre: any) => {
    const {getNamedAccounts, deployments, network } = hre
    const {deploy, log} = deployments
    const {deployer} = await getNamedAccounts()  // When using this method, we must set up "namedAccounts" our hardhat.config
    const chainId: any = network.config.chainId
    // when going for localhost or hardhat network we want to use a mock

    // Using various walled addresses on multiple chains
    // If chain is X use Y
    // If chain is Z use A
    let ethUsdPriceFeedAddress;
    if (developmentChains.includes(network.name)) {
        const ethUsdAggregator = await deployments.get("MockV3Aggregator")
        ethUsdPriceFeedAddress = ethUsdAggregator.address
    } else {
        ethUsdPriceFeedAddress = networkConfig[chainId]["ethUsdPriceFeed"]
    }
    

    const args = [ethUsdPriceFeedAddress]
    
    const fundMe = await deploy("FundMe", {
        from: deployer,
        args: args,
        log: true,
        waitConfirmations: network.config.waitConfirmations,
    })

    if (!developmentChains.includes(network.name && process.env.ETHER_SCAN_API_KEY)) {
        // await verify(fundMe.address, args)
        console.log("Skipped this if statment for local deployment...")
    }
    log("________________________________________________________________")
}

module.exports.tags = ["all", "fundme"]