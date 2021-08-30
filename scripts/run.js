async function main() {
    const [owner, randoPerson] = await ethers.getSigners();
    const buildSpaceContractFactory = await hre.ethers.getContractFactory("BuildSpace");
    const buildSpaceContract = await buildSpaceContractFactory.deploy();
    await buildSpaceContract.deployed();
    
    console.log("Contract deployed to:", buildSpaceContract.address);
    console.log("Contract deployed by:", owner.address);
    console.log("randoPerson address:", randoPerson.address);
    
    let waveCount;
    waveCount = await buildSpaceContract.getTotalWaves();
    
    let waveTxn;
    waveTxn = await buildSpaceContract.wave();
    await waveTxn.wait();
    
    waveCount = await buildSpaceContract.getTotalWaves();
    
    waveTxn = await buildSpaceContract.connect(randoPerson).wave();
    await waveTxn.wait();
    
    waveTxn = await buildSpaceContract.addWaver(randoPerson.address, "Bob");
    await waveTxn.wait();
    
}

main()
  .then((() => process.exit(0)))
  .catch((error) => { 
      console.error(error);
      process.exit(1);
  });
  
  

