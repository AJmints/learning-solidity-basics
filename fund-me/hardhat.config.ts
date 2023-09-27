import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config"
import "solidity-coverage"

const config: HardhatUserConfig = {
  solidity: "0.8.7",
};

export default config;
