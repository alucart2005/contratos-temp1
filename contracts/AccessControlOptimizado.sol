// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract AccessControlOptimizado {
    address private  owner;
    uint private secretNumber;

    constructor () {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function setSecretNumber(uint _newNnumber) public onlyOwner {
        secretNumber = _newNnumber;
    }

    function getSecretNumber() public view returns (uint) {
        return secretNumber;
    }
}