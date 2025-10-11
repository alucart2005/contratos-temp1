// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

contract DesplazandoIzquierda {
    uint[] public array;

    function deleteArray() public {
        array = [1, 2, 3];
        delete array[1];
    }

    function remove(uint _index) public {
        require(_index < array.length, "Indice fuera de rango");
        
        for (uint i = _index; i < array.length - 1; i++) {
            array[i] = array[i +1];
        }
        array.pop();
    }

    function prueba() external {
        array = [1, 2, 3, 4, 5, 6];
        remove(1);
        assert(array[0] == 1);
        assert(array[1] == 3);
        assert(array[2] == 4);
        assert(array[3] == 5);
        assert(array[4] == 6);
        assert(array.length == 5);
    }

    function prueba2(uint _index2) external returns (uint[] memory){
        array = [1, 2, 3, 4, 5, 6];
        remove(_index2);
        return array;
    }

}

contract RemplazarUltimo {
//    uint[] public array;
    uint[] public array = [1, 2, 3, 4, 5, 6];

    function remove(uint _index) public {
        array[_index] = array[array.length - 1];
        array.pop();
    }

    function prueb() external {
        array = [1, 2, 3, 4, 5, 6];
        remove(1);
        assert(array[0] == 1);
        assert(array[1] == 6);
        assert(array[2] == 3);
        assert(array[3] == 4);
        assert(array[4] == 5);
        assert(array.length == 5);
    }

    function mostrarArray() public view returns ( uint[] memory ){
        return array;
    }
}