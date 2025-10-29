// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

//import {console} from "forge-std/console.sol";
contract RamdomnessVulnerable {
    uint private seed;
    uint public randomNumber;

    constructor() {
        seed = block.timestamp;
    }

    function generateRandomNumber() public {
        randomNumber = uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp, seed)));
    }
}