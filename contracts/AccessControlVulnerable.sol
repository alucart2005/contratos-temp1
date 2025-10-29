// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract AccessControlVulnerable {
    address public owner;
    uint public secretNumber;

    constructor () {
        owner = msg.sender;
    }

    function setSecretNumber(uint _newNnumber) public {
        secretNumber = _newNnumber;
    }

    function getSecretNumber() public view returns (uint) {
        return secretNumber;
    }
}