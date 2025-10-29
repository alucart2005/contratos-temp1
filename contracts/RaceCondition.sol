// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract RaceCondition {
    uint256 public balance;
    mapping (address => uint256) public balances;

    function depositar() public payable {
        balances[msg.sender] += msg.value;  //saldo remitente
        balance += msg.value;               //saldo contrato
    }

    function retirar(uint256 _cant) public {
        require(balances[msg.sender] >= _cant, "Saldo insuficiente");
        uint256 saldoAnterior = balances[msg.sender]; //saldo anterior

        balances[msg.sender] -= _cant;
        require(payable(msg.sender).send(_cant), "Error al realizar la transferencia");
        require(balances(msg.sender) == saldoAnterior, "Race condition detectada");
        //balance -= _cant; //saldo contrato
        //assert(saldoAnterior == balances[msg.sender] + _cant);
        
    }
}