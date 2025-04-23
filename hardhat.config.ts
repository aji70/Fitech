// import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config({ path: ".env" });

module.exports = {
  solidity: "0.8.22",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_URL,

      accounts: [process.env.ACCOUNT_PRIVATE_KEY],
    },
  },

  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};
