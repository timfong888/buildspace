async function main() {
    //const [owner, randoPerson] = await ethers.getSigners()
    const buildSpaceContractFactory = await hre.ethers.getContractFactory("BuildSpace")
    const buildSpaceContract = await buildSpaceContractFactory.deploy({value: hre.ethers.utils.parseEther("0.1")})
    await buildSpaceContract.deployed()
    
    console.log("Contract deployed to:", buildSpaceContract.address)
    
    let contractBalance = await hre.ethers.provider.getBalance(buildSpaceContract.address)
    console.log("Contract balance:", hre.ethers.utils.formatEther(contractBalance))
    
    //console.log("Contract deployed by:", owner.address)
    //console.log("randoPerson address:", randoPerson.address)
    
    let waveCount = await buildSpaceContract.getTotalWaves()
    
    let throwTxn = await buildSpaceContract.throwHand(0, "message1")
    await throwTxn.wait()
    
    throwTxn = await buildSpaceContract.throwHand(1, "message2")
    await throwTxn.wait()
    
    throwTxn = await buildSpaceContract.throwHand(2, "message2")
    await throwTxn.wait()
    
    contractBalance = await hre.ethers.provider.getBalance(buildSpaceContract.address)
    console.log("Contract balance:", hre.ethers.utils.formatEther(contractBalance))
    
    let allThrows = await buildSpaceContract.getAllThrows()
    console.log(allThrows)
    

}

main()
  .then((() => process.exit(0)))
  .catch((error) => { 
      console.error(error);
      process.exit(1);
  });
  
  

