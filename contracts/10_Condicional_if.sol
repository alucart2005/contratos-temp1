// SPDX-License-Identifier: MIT
pragma solidity >=0.8.13 <0.9.0;

contract SentenciaIf {
    function numeroGanador(uint _numero) public pure returns (string memory) {
        if (_numero == 7) {
            return "Eres el ganador!"; // Si el número es 7, devuelve este mensaje
        } else {
            return "No eres el ganador"; // Si el número no es 7, devuelve este mensaje
        }
    }

    function valorAbsoluto(int _numero) public pure returns (int) {
        return _numero < 0 ? _numero * -1 : _numero; // Si el número es menor que 0, devuelve el número multiplic
    }

    function esParDeTrs(uint _numero)  public pure returns (bool) {
        return (_numero % 2 == 0 && _numero >=100 && _numero <= 999) ? true : false; // Si el número es divisible por 2 y está entre 100 y 999); // Si el número es divisible por 2 y por
    }

    function votar(string memory _candidato) public pure returns (string memory){
        if (esIgual(_candidato, "Ronaldinho")){
            return "Votaste por Ronaldinho"; // Si el candidato es Ronaldinho, devuelve este mensaje
        } else if (esIgual(_candidato, "Messi")){
            return "Votaste por Messi"; // Si el candidato es Messi, devuelve este mensaje
        } else if (esIgual(_candidato, "Cristiano")){
            return "Votaste por Cristiano"; // Si el candidato es Cristiano, devuelve este mensaje
        } else {
            return "No es un candidato valido"; // Si el candidato no es ninguno de los anteriores, devuelve este mensaje
        }
    }

     function esIgual(string memory _a, string memory _b) public pure returns (bool) {
        return keccak256(abi.encodePacked(_a)) == keccak256(abi.encodePacked(_b)); // Si los dos strings son iguales, devuelve true
    }
    
}