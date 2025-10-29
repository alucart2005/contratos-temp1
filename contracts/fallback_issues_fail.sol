// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract VulnerableFallBack {
    mapping ( address => uint256 ) public balances;
    
    fallback() external payable { 
        balances[msg.sender] += msg.value;
        ( bool success, ) = msg.sender.call{value: msg.value}(""); // call to the fallback function of the caller
        require(success, "Transferencia Fallida");
    }

    function withdraw() public {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Saldo insuficiente");

        balances[msg.sender] = 0;
        
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transferencia Fallida");
    }
}