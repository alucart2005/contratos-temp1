// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

contract TestConstructor {

  address owner;

  constructor (){
    owner = msg.sender;
  }

  function getOwner() public view returns (address) {
    return owner;
  }
}  

