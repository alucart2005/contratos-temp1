// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VisibilityExample {
    uint256 private privateNumber;  // Solo accesible dentro del contrato
    uint256 internal internalNumber; // Accesible dentro del contrato y en contratos heredados
    uint256 public publicNumber;    // Solidity genera automáticamente un getter público

    // --- FUNCIONES PRIVATE ---
    // Solo pueden ser llamadas desde dentro del contrato (ni siquiera desde contratos heredados).
    function _setPrivateNumber(uint256 _num) private {
        privateNumber = _num;
    }

    // --- FUNCIONES INTERNAL ---
    // Pueden ser llamadas desde el contrato o desde contratos que hereden de este.
    function _setInternalNumber(uint256 _num) internal {
        internalNumber = _num;
    }

    // Función internal que usa otra private (solo visible dentro del contrato).
    function _updateNumbers(uint256 _privateNum, uint256 _internalNum) internal {
        _setPrivateNumber(_privateNum);  // Llama a la función private
        _setInternalNumber(_internalNum); // Llama a la función internal
    }

    // --- FUNCIONES PUBLIC ---
    // Pueden ser llamadas desde cualquier lugar (dentro/ fuera del contrato).
    // Solidity genera automáticamente un getter para `publicNumber`.
    function setPublicNumber(uint256 _num) public {
        publicNumber = _num;
    }

    // --- FUNCIONES EXTERNAL ---
    // Solo pueden ser llamadas desde **fuera** del contrato (no desde otras funciones del contrato).
    // Ahorran gas en llamadas externas porque no copian `msg.sender`/`msg.value` al stack.
    function setAllNumbers(uint256 _privateNum, uint256 _internalNum, uint256 _publicNum) external {
        _updateNumbers(_privateNum, _internalNum); // Llama a la función internal
        setPublicNumber(_publicNum);               // Llama a la función public
    }

    // --- GETTERS (para variables private/internal) ---
    // Funciones public para exponer variables private/internal.
    function getPrivateNumber() public view returns (uint256) {
        return privateNumber;
    }

    function getInternalNumber() public view returns (uint256) {
        return internalNumber;
    }
}


contract Caller {
    function callExternalFunction(address _contractAddr, uint256 a, uint256 b, uint256 c) public {
        VisibilityExample(_contractAddr).setAllNumbers(a, b, c); // Llama a la función external
        // VisibilityExample(_contractAddr)._setPrivateNumber(a); // ERROR: no puede llamar a private
    }
}

contract ContratoDerivado is VisibilityExample {
    function actualizarNumerosExternos (uint256 _privateNum, uint256 _internalNum) public {
        _updateNumbers(_privateNum, _internalNum);
    }
}

/*
Explicación clave:



    private:


        Solo accesible dentro del contrato donde se define.

        Ejemplo: _setPrivateNumber solo puede ser llamada desde otras funciones de VisibilityExample.




    internal:


        Accesible dentro del contrato y en contratos que hereden de él.

        Ejemplo: _setInternalNumber podría ser llamada desde un contrato hijo que herede VisibilityExample.




    public:


        Accesible desde cualquier lugar (dentro/fuera del contrato).

        Solidity genera automáticamente un getter para variables públicas (ej: publicNumber tiene un getter implícito).

        Ejemplo: setPublicNumber puede ser llamada desde otra cuenta o contrato.




    external:


        Solo puede ser llamada desde fuera del contrato (no desde otras funciones internas).

        Más eficiente en gas para llamadas externas porque optimiza el paso de parámetros como msg.sender.

        Ejemplo: setAllNumbers no puede ser llamada desde _updateNumbers, pero sí desde otro contrato o EOA.





¿Cuándo usar cada una?

Visibilidad	Uso típico	Ejemplo
private	Lógica interna que nunca debe exponerse.	Validaciones internas o helpers.
internal	Lógica reutilizable en herencia.	Funciones de biblioteca o lógicas compartidas.
public	API del contrato para interacción externa.	Setters/getters para usuarios.
external	Funciones solo para llamadas externas (ahorra gas).	Funciones de entrada principal del contrato.
*/