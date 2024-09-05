const { ethers, upgrades } = require("hardhat");

async function main() {
  console.log("Deploying my MyToken....");

  const MyToken = await ethers.getContractFactory("MyToken");
  const myToken = await upgrades.deployProxy(MyToken, ["MyToken", "MTK"], {
    intitializer: "initialize",
  });

  console.log(" MyToken deployed to:", myToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
