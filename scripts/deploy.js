const { ethers, upgrades } = require("hardhat");

async function main() {
  //Get the Deployer's account
  const [deployer] = await ethers.getSigners();
  console.log(" deploying contract with the account", deployer.address);

  const StakingContract = await ethers.getContractFactory("StakingContract");

  const erc20Address = "0x9188eC23638C08473ea3406B98b4564241E959Ad";
  const erc721Address = "0x3e18D1e92194Ebf1428115541734c318f77Fbd2c";

  const stakingContract = await upgrades.deployProxy(
    StakingContract,
    [erc20Address, erc721Address],
    { initializer: "initialize" }
  );
  await stakingContract.deployed();

  console.log("Deployin StakingContrat to...", stakingContract.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
