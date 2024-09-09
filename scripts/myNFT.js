const { ethers, hardaht } = require("hardhat");

async function main() {
  console.log("deploying MyNFT.....");

  const MyNFT = await ethers.getContractFactory("contracts/MyNFT.sol:MyNFT");
  const myNFT = await upgrades.deployProxy(MyNFT, [], {
    initializer: "initialize",
  });

  await myNFT.deployed();

  console.log("MyNFT deployed to:", myNFT.address);
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
