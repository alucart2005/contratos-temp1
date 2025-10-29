// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract RaceConditionGod {
    uint256 public balance;
    mapping (address => uint256) public balances;
    mapping (address => bool) public isTransfering;

    function depositar() public payable {
        balances[msg.sender] += msg.value;  //saldo remitente
        balance += msg.value;               //saldo contrato
    }

    function retirar(uint256 _cant) public {
        require(balances[msg.sender] >= _cant, "Saldo insuficiente");
        require(!isTransfering[msg.sender], "No se puede retirar mientras se esta transfiriendo");

        isTransfering[msg.sender] = true;

        //require(payable(msg.sender).send(_cant), "Error al realizar la trasnferencia");
        (bool success, ) = (payable(msg.sender).call{value: _cant}(""));
        require(success, "Error al realizar la transferencia");

        balances[msg.sender] -= _cant;
        isTransfering[msg.sender] = false;
    }
}