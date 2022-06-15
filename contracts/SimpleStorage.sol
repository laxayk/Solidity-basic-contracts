// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage{
    uint256 public favouriteNumber;
    Dumbs[] public dumbsList;
    mapping(string => uint256) public myDict;

    struct Dumbs{
        uint256 num;
        string name;
    }

    function store(uint256 _favouriteNumber) public{
        favouriteNumber = _favouriteNumber;
    }   

    function addToDumbs(uint256 _num, string memory _name) public{
        dumbsList.push(Dumbs(_num,_name));
        myDict[_name] = _num;
    }
}   