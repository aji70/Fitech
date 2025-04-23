// import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config({ path: ".env" });

module.exports = {
  solidity: "0.8.22",
  networks: {
    hardhat: {},
    sepolia: {
      url: process.env.SEPOLIA_URL,

      accounts: [process.env.ACCOUNT_PRIVATE_KEY],
    },
  },
  lockGasLimit: 200000000000,
  gasPrice: 10000000000,
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};
