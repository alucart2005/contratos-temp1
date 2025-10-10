// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Propietario {
    address public propietario;

    constructor() {
        propietario = msg.sender;
    }

    modifier soloPropietario() {
        require(msg.sender == propietario, "No eres el propietario");
        _;
    }

    function setPropietario(address _newOwner) external soloPropietario {
        require(_newOwner != address(0), "direccion invalida");
        propietario = _newOwner;
    }

    function soloPropietarioPuedeLLamar() view external soloPropietario returns (string memory) {
        return "Funcion ejecutada por el propietario del contrato";
    }

    function cualquieraPuedeLLAmar() pure external returns (string memory) {
        return "Funcion ejecutada por cualquier usuario";
    }
}