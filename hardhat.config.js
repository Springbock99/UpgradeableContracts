require("@nomiclabs/hardhat-ethers");
require("@openzeppelin/hardhat-upgrades");

module.exports = {
  solidity: "0.8.20",
  networks: {
    localhost: {
      url: "http://127.0.0.1:8545",
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/ac78ca36487049c985895bd77a24493f`,
      accounts: [
        `fad9d6ddc2f5e908b2bdb683728dc83b721d355e4e46fd798d2f2b8e687164ff`,
      ],
    },
  },
  etherscan: {
    apiKey: "I4V1HN7DYIXTM67UX5AUPWAIRYBJ7QPRFS",
  },
};
