async function main() {
    const [deployer] = await ethers.getSigners(); // https://docs.ethers.io/v5/api/signer/
    
    console.log("Deploying contracts with account:", deployer.address);
    console.log("Account balance:", (await deployer.getBalance()).toString());
    
    const Token = await ethers.getContractFactory("BuildSpace"); //https://docs.ethers.io/v5/api/contract/contract-factory/
    
    const token = await Token.deploy();
    
    console.log ("Token: ", Token);
    console.log ("token:", token);
    
    console.log("BuildSpace contract address: %s", token.address);
    
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    })