const { ethers, upgrades } = require("hardhat");
const fs = require("fs");

// Function to generate the JSON file name and content
async function main() {
  const contractName = "MyNFT"; // You can modify this to use a variable if needed
  const jsonFileName = `${contractName}_deployedAddress.json`; // Default file name

  console.log(`Deploying ${contractName}...`);

  const MyNFT = await ethers.getContractFactory("contracts/MyNFT.sol:MyNFT");
  const myNFT = await upgrades.deployProxy(MyNFT, [], {
    initializer: "initialize",
  });

  await myNFT.deployed();

  console.log(`${contractName} deployed to:`, myNFT.address);

  const addressData = {
    name: contractName,
    address: myNFT.address,
    deployedAt: new Date().toISOString(),
  };

  fs.writeFileSync(jsonFileName, JSON.stringify(addressData, null, 2));
  console.log(`Contract address saved to... ${jsonFileName}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
