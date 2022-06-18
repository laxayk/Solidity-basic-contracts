// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTest{

    uint8 public randomNumber = 255;

    function add() public {
        randomNumber+=1; //Reverts
        unchecked {randomNumber+=1;} //Wraparound
    }
}