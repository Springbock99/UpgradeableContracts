const { ethers, upgrades } = require("hardhat");
const fs = require("fs");

async function main() {
  const contractName = "MyToken"; // Define the contract name
  const jsonFileName = "deployedAddresses.json"; // JSON file to store addresses

  console.log(`Deploying ${contractName}...`);

  // Get the contract factory for MyToken
  const MyToken = await ethers.getContractFactory(contractName);

  // Deploy the contract using a proxy
  const myToken = await upgrades.deployProxy(MyToken, ["MyToken", "MTK"], {
    initializer: "initialize", // Note: Corrected the typo in "initializer"
  });

  await myToken.deployed();

  console.log(`${contractName} deployed to:`, myToken.address);

  // Create the JSON object for the new contract
  const newContractData = {
    name: contractName,
    address: myToken.address,
    deployedAt: new Date().toISOString(), // Optional: include the deployment timestamp
  };

  // Check if the JSON file already exists
  let deployedData = [];
  if (fs.existsSync(jsonFileName)) {
    const existingData = fs.readFileSync(jsonFileName);
    deployedData = JSON.parse(existingData); // Parse existing data
  }

  // Append the new contract data to the existing data
  deployedData.push(newContractData);

  // Write the updated data back to the JSON file
  fs.writeFileSync(jsonFileName, JSON.stringify(deployedData, null, 2));
  console.log(`Contract addresses saved to ${jsonFileName}`);
}

// Execute the main function
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
