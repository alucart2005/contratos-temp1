// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract TestFuncions {

    address[] private direcciones;

    function agregarDirecion() public  {
        direcciones.push(msg.sender);
    }

    function obtenerDireccion(uint _index) public view returns (address){
        return direcciones[_index];
    }

    // mostrar todo el arreglo
    function obtenerDirecciones() public view returns (address[] memory){
        return direcciones;
    }
}