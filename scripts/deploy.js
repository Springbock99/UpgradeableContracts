const { ethers, upgrades } = require("hardhat");

async function main() {
  //Get the Deployer's account
  const [deployer] = await ethers.getSigners();
  console.log(" deploying contract with the account", deployer.address);

  const StakingContract = await ethers.getContractFactory("StakingContract");

  const erc20Address = "";
  const erc721Address = "";

  const stakingContract = await upgrades.deployProxy(
    StakingContract,
    [erc20Address, erc721Address],
    { initializer: "initialize" }
  );
  await stakingContract.deployed();

  console.log("Deployin StakingContrat to..", stakingContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
