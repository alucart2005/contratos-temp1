// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract LLamarContratoPrueba {
    // Funcion para establecer el valor de x en el contrato Contrato de prueba
    function setX(ContratoPrueba _test, uint _x) external {
        _test.setX(_x);
    }

    // Funcion para obtener el valor de x en el contrato Contrato de prueba 
    function getX(address _test) external view returns (uint x) {
        x = ContratoPrueba(_test).getX();
    }

    // Funcion para establecer el valor de x y enviar Ether
    function setXandSendEther(address _test, uint _x) external payable {
        ContratoPrueba(_test).setXandReciveEther{value: msg.value}(_x);
    }

    // Funcion para obtener el valor de x y el ether almacenado
    function getXanadValue(address _test) external view returns (uint x, uint value){
        (x, value) = ContratoPrueba(_test).getXandValue();
    }
}

contract ContratoPrueba {
    uint public x;
    uint public  value;

    function setX(uint _x) external {
        x = _x;
    }

    function getX() external view returns (uint) {
        return x;
    }

    function setXandReciveEther(uint _x)  external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint, uint) {
        return (x, value);
    }
}