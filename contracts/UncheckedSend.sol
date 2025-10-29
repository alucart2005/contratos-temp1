// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract UncheckedSend {
    mapping(address => uint256) public balances;

    function deposit() public {
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        require(success, "Fallo el envio");
    }
}