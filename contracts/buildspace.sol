// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@chainlink/contracts/src/v0.8/VRFConsumerBase.sol"; //Chainlink 

contract BuildSpace {
    
    uint public totalWaves = 0;
    
    event NewThrow(address indexed from, handOptions hand, uint timestamp, string message, string winner);
    
    enum handOptions {
        rock,
        paper,
        scissors
    }
    
    handOptions public hand;
    
    struct handThrow {
        address throwerAddress; //address of the person who threw
        handOptions hand; // "rock", "paper", "scissors"
        uint timestamp; // timestamp of throw
        string message; // message from the one throwing
        string winner; // stores whether this hand wins (win, tie, loss)
    }
    
    
    //throwsArray is the array of all handThrows, which are a custom data type (Struct)
    handThrow[] throwsArray;
    handThrow lastThrow;
    
    string win_state;
    
    constructor() payable {
        console.log("Yo yo, I am a contract and I am smart:", block.timestamp);
    }
    
    function wave(string memory _hand) public {
        totalWaves +=1;
        
        // each wave also needs to pass a "rock", "paper", "scissors"
        console.log("%s just waved with a %s", msg.sender, _hand);
    }
    
    function throwHand(handOptions _handOption, string memory _message) public {
        
        // the throw passes "rock", "paper", "scissors"    
        console.log("thrower %s:  message: %s", msg.sender , _message);

        // if the Array is empty, skip down to adding setting this throw the winner and do not compare
        if (throwsArray.length != 0) {
            
            // retrieves the last throw in Array?
            lastThrow = throwsArray[throwsArray.length - 1];
            
            //console.log("lastThrow was: %s ", lastThrow.toString());
        
            // logic -- winner = true?
            
            
            if (_handOption == handOptions.rock) {
                if (lastThrow.hand == handOptions.paper) {
                    win_state = "lose: paper beats rock";
                } else if (lastThrow.hand == handOptions.rock) {
                    win_state = "tie: rock and rock";
                } else
                    win_state = "win: rock crushes scissors";
            } else if (_handOption == handOptions.paper) {
                if (lastThrow.hand == handOptions.scissors) {
                    win_state = "lose: paper is cut down by scissors";
                } else if (lastThrow.hand == handOptions.paper) {
                    win_state = "tie: paper paper!";
                } else
                    win_state = "win: paper wraps up rock!";
            } else {
                if (lastThrow.hand == handOptions.rock) {
                    win_state = "lose: scissors gets damaged by rock";
                } else if (lastThrow.hand == handOptions.scissors) {
                    win_state = "tie: scissors scissors";
                } else
                    win_state = "win: scissors cuts down paper";
            }
            
            
            console.log("last hand: %d, current hand: %d, win_state: %s", uint(lastThrow.hand), uint(_handOption), win_state);

            
        } else { // this means it's the first throw and there's an automatic winner and no comparison
        
            win_state = "first throw";
            console.log("this is the first throw");
        }
        
        // add throw to the Array
        throwsArray.push(handThrow(msg.sender, _handOption, block.timestamp, _message, win_state));
        emit NewThrow(msg.sender, _handOption, block.timestamp, _message, win_state);
        
        uint prizeAmount = 0.0001 ether;
        require(prizeAmount <= address(this).balance);
        (bool success,) = (msg.sender).call{value: prizeAmount}("");
        require(success, "Failed to withdraw from contract.");
        
    }
    
    function getTotalWaves() public view returns (uint) {
        console.log("We have %d total waves", totalWaves);
        return totalWaves;
    }
    
    function getAllThrows() public view returns (handThrow[] memory) {
        return throwsArray;
    }
    
}