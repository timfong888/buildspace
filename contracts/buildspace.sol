// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol"; //Chainlink 


contract BuildSpace {
    
    uint public totalWaves = 0;
    
    string public waverName;
    string[] public namesArray;
    
    string[] public handArray = ["rock", "paper", "scissors"];
    
    
    bool winner;
    
    // Map address to a "name"
    mapping(address => string) public waverAddressNames;
    
    constructor() {
        console.log("Yo yo, I am a contract and I am smart");
    }
    
    function wave(string memory _hand) public {
        totalWaves +=1;
        
        // each wave also needs to pass a "rock", "paper", "scissors"
        console.log("%s just waved with a %s", msg.sender, _hand);
    }
    
    function getTotalWaves() public view returns (uint) {
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
    
    // store the address of each person who waves
    
    function addWaver(address _waverAddress, string memory _waverName) public {
        waverAddressNames[_waverAddress] = _waverName;
        console.log("%s is named %s", _waverAddress, _waverName);
    }
    
}