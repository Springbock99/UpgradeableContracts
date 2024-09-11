const { ethers, hardhat } = require("hardhat");

async function main() {
  console.log("upgrading MyNFT....");

  const MyNFTV2 = await ethers.getContractFactory(
    "contracts/UpgradeMyNFT.sol:MyNFT"
  );
  const myNFT = await upgrades.upgradeProxy(
    0x3e18d1e92194ebf1428115541734c318f77fbd2c,
    MyNFTV2
  );

  console.log("MyNFT upgraded to:", myNFT.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
