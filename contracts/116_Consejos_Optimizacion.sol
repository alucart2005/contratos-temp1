// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Inicio – transaction cost	51383 unidades de gas:

– Usar calldata  49637 gas 
– Cargar variables de estado en la memoria 49207 gas
– Cortocircuito    	48274 gas
– Incrementos de bucle
– Caché de la longitud del array 48239 gas
– Cargar elementos del array en la memoria
*/

contract GasRefactor {
    uint public total;
    // [1, 4, 7, 8, 9, 100]
    function sumar(uint256[] calldata _nums)  external {
        uint256 _total = total;
        uint256 length = _nums.length;
        for (uint256 i; i < length;) {
            uint256 num = _nums[i];
            if (num % 2 == 0 && num < 100) {
                _total += num;
            }
            unchecked { ++i; }    
        }
        total = _total;
    }
}
