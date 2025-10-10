// SPDX-License-Identifier: MIT
pragma solidity >0.8.8 < 0.9.0;

contract ModificadoresVPP {
    string[] public nombres;
    uint x = 10;

    function agregarNombres(string memory _nombre) public {
        nombres.push(_nombre);
    }

    function verNombres(uint _index) public view returns (string memory){
        return nombres[_index];
    }

    function sumarAyX(uint _a) public view returns (uint){
        return _a + x;
    }

    function multiplicar(uint _a, uint _b) pure  public returns (uint){
        return _a * _b ;
    }
}