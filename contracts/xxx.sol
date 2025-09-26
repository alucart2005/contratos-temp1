// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract XXX {

    uint256 public number;
    address public owner;

    constructor(uint256 _number) {
        number = _number;
        owner = msg.sender;
    }

    function setNumber(uint256 _number) public {
        number = _number;
    }
}