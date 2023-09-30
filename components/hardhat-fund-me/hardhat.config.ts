import { HardhatUserConfig } from "hardhat/config"
import "@nomicfoundation/hardhat-toolbox"
import "dotenv/config"
import "solidity-coverage"
import "hardhat-deploy"
import "@typechain/hardhat"

const SEPOLIA_RPC_URL: any = process.env.SEPOLIA_RPC_URL || "https://eth-sepolia-example"
const MUMBAI_RPC_URL: any = process.env.MUMBAI_RPC_URL || "https://eth-mumbai-example"
const PRIVATE_KEY: any = process.env.SEPOLIA_PRIVATE_KEY || "0xKey"
const ETHERSCAN_API_KEY: any = process.env.ETHER_SCAN_API_KEY || "key"
const COINMARKETCAP_API_KEY: any = process.env.COINMARKETCAP_API_KEY || "key"
const POLYGONSCAN_API_KEY: any = process.env.POLYGONSCAN_API_KEY || "key"

const config: HardhatUserConfig = {
  defaultNetwork: "hardhat",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 11155111,
    },
    mumbai: {
      url: MUMBAI_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 80001,
    },
    localhost: {
      url: "http://127.0.0.1:8545/",
      chainId: 31337,
    },
  },
  solidity: {
    compilers: [
      { version: "0.8.7",}, {version: "0.6.6",}],
  },
  etherscan: {
    apiKey: {
      sepolia: ETHERSCAN_API_KEY,
      polygonMumbai: POLYGONSCAN_API_KEY,
    }
  },
  gasReporter: {
    enabled: false, // set to true to view gas reporter
    outputFile: "gas-report.txt",
    noColors: true,
    currency: "USD",
    coinmarketcap: COINMARKETCAP_API_KEY,
  },
  namedAccounts: {
    deployer: {
      default: 0,
    },
    user: {
      default: 1,
    }
  },
  
};

export default config;
