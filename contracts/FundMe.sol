// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract FundMe{

    uint256 public minimumFund = 50 * 1e18;

    // constructor() payable{
    //     val = msg.value;
    // }

    function Fund() public payable{
        bool condition = GetConversionRate(msg.value) >= minimumFund;
        require(condition, "Didn't send enough");
    }

    function GetPrice() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
         (,int256 price,,,) = priceFeed.latestRoundData();
         return uint256(price * 1e10);
    }

    function GetVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
        return priceFeed.version();
    }

    function GetConversionRate(uint256 _etherAmount) public view returns(uint256){
        uint256 ethPrice = GetPrice();
        uint256 ethAmountInUsd = (ethPrice * _etherAmount)/1e18;
        return ethAmountInUsd;
    }

    // function Withdraw(){

    // }
}