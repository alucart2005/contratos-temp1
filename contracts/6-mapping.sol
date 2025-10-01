/*
// SPDX-License-Identifier: MIT
*/
pragma solidity ^0.8.3;

/*
contract TestMapping { 
    // Ejercicio 1 mapping
    // Mapping que permite elegir un nombre mediante un numero
    mapping(uint => string) private nombres;

    // Usar mapping
    function asignarNombre(uint _numero, string memory _nombre) public {
        nombres[_numero] = _nombre;
    }
    
    // Obtener nombres
    function obtenerNombre(uint _numero) public view returns(string memory) {
        return nombres[_numero];
    }

}
*/

// Ejercicio # 2 
// Mapping que nos relaciona una struct Persona con un address

contract TestMapping { 

    // Crear el mapping
    mapping(address => Persona) private sujetos;

    // struct persona
    struct Persona {
        uint id;
        string nombre;
        uint8 edad;
    }

    // funcion que permite asignar sujeto a la struct creada
    function asignarSujeto(uint _id, string memory _nombre, uint8 _edad) public {
        // Crear una sujeto
        Persona memory sujeto = Persona(_id, _nombre, _edad);

        // Asignar el sujeto al mapping sujetos 
        sujetos[msg.sender] = sujeto;
    }

    /*function obtenerSujeto(address _miembro) public view returns (uint, string memory, uint8) {
        return (sujetos[msg.sender].id, sujetos[msg.sender].nombre, sujetos[msg.sender].edad);
    }*/

    function obtenerDatos(address _direccion) public view returns (uint, string memory, uint8) {
        return (sujetos[_direccion].id, sujetos[_direccion].nombre, sujetos[_direccion].edad);
    }
}
