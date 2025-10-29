// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

library Math {
    function max(uint x, uint y) internal pure returns (uint) {
        return x >= y ? x : y;
    }
}

contract Test {
    function tesxMax(uint x, uint y) external pure returns (uint) {
        return Math.max(x, y);
    }
}

// Funcion que permita hubicar la posicion de un numero

library ArrayLib {
    function find(uint[] storage _arr, uint _x) internal view returns (uint) {
        for (uint i = 0; i < _arr.length; i++) {
            if (_arr[i] == _x) {
                return i;
            }
        }
        revert("No se encontro en el array");
    }
}

contract TestArray {
    uint[]public arr = [1,2,3,4,5,6,7,8,9,10];

    function testFind(uint _num) external view returns (uint i) {
        return ArrayLib.find(arr, _num);
    }
}


