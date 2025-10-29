// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

/*
Selfdestruct
Eliminar Contrato
Forzar el envio de ether a cualquier direccion
*/
contract Kill {
    constructor() payable  {}
        
    function killContract() external  {
        selfdestruct(payable (msg.sender));              //Elimina el contrato y envia el balance a la direccion que lo llamo
    }

    function testContract() external view returns (string memory) {
        require(address(this).code.length > 0, "El contrato ha sido eliminado");
        return "Estoy funcionando";
    }
}