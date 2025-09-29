// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract3 {
    uint32 private sum;
    uint32 private product;
    address public owner;

    // Evento para registrar operaciones
    event OperationPerformed(
        address indexed caller,
        uint32 num1,
        uint32 num2,
        uint32 resultSum,
        uint32 resultProduct
    );

    constructor() {
        owner = msg.sender;
    }

    /**
     * @dev Calcula la suma y multiplicación de dos números
     * @param num1 Primer número (entero sin signo)
     * @param num2 Segundo número (entero sin signo)
     */
    function calculate(uint32 num1, uint32 num2) external {
        require(num1 > 0 && num2 > 0, "Numbers must be greater than zero");

        sum = num1 + num2;
        product = num1 * num2;

        emit OperationPerformed(msg.sender, num1, num2, sum, product);
    }

    /**
     * @dev Devuelve la suma almacenada
     * @return La suma de los dos números
     */
    function getSuma() external view returns (uint32) {
        return sum;
    }

    /**
     * @dev Devuelve el producto almacenado
     * @return El producto de los dos números
     */
    function getMultiplicacion() external view returns (uint32) {
        return product;
    }

    /**
     * @dev Devuelve ambos resultados en una sola llamada (optimización de gas)
     * @return tuple con suma y producto
     */
    function getResultsSumaProducto() external view returns (uint32, uint32) {
        return (sum, product);
    }
}