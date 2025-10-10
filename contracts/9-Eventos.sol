// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Eventos {
    event DepositosTest(string indexed nombre);
    event DepositosTest2(string indexed nombre, uint cantidad);
    event DepositosTest3(string, uint, address indexed, bytes32);

    // Evento
    function depositar(string memory _nombre) public {
        emit  DepositosTest(_nombre);
    }

    function depositar2(string memory _nombre, uint _cantidad) public {
        emit DepositosTest2(_nombre, _cantidad);
    }

    function depositar3(string memory _nombre, uint _edad) public {
        bytes32 hashId = keccak256(abi.encodePacked(_nombre, _edad, msg.sender));
        emit DepositosTest3(_nombre, _edad, msg.sender, hashId);
    }
}