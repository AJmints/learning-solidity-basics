import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config"
import "solidity-coverage"

//Example of having backup options for our environment variables if they aren't specified
const SEPOLIA_RPC_URL: any = process.env.SEPOLIA_RPC_URL || "https://eth-sepolia-example"
const PRIVATE_KEY: any = process.env.SEPOLIA_PRIVATE_KEY || "0xKey"
const ETHERSCAN_API_KEY: any = process.env.ETHER_SCAN_API_KEY || "key"
const COINMARKETCAP_API_KEY: any = process.env.COINMARKETCAP_API_KEY || "key"

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 11155111,
    },
    localhost: {
      url: "http://127.0.0.1:8545/",
      // accounts: hardhat is doing magic behind the scenes, thanks hardhat!
      chainId: 31337,
    }
  },
  solidity: "0.8.7",
  etherscan: {
    apiKey: ETHERSCAN_API_KEY,
  }, 
  gasReporter: {
    enabled: false, // set to true to view gas reporter
    outputFile: "gas-report.txt",
    noColors: true,
    currency: "USD",
    coinmarketcap: COINMARKETCAP_API_KEY,
  }
};


export default config;