// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe{

    using PriceConverter for uint256;

    uint256 public minimumFund = 50 * 1e18;
    address[] public fundersList;
    mapping(address => uint256) public addreddToAmountFeed;

    address public owner;

    constructor(){
        owner = msg.sender;
    }

    function Fund() public payable{
        require(msg.value.GetConversionRate() >= minimumFund, "Didn't send enough");
        fundersList.push(msg.sender);
        addreddToAmountFeed[msg.sender] += msg.value;
    }

    function Withdraw() public onlyOwner{
        for(uint256 i =0; i<fundersList.length; i++){
            addreddToAmountFeed[fundersList[i]] = 0;
        }
        fundersList = new address[](0);

        // //Transfer
        // payable(msg.sender).transfer(address(this).balance);
        // //Send
        // bool isSuccess = payable(msg.sender).send(address(this).balance);
        // require(isSuccess, "send Failed");
        //Call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "call Failed");
    }

    modifier onlyOwner{
        require(msg.sender == owner, "You ain't the owner mf!");
        _;
    }
}