// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

interface RandomnessOracle{
    function getRandomNumber() external returns (uint);
}
contract RandomneessOptimizado {
    uint public randomNumber;
    address private oracle;

    constructor(address _oracleAddress) {
        oracle = _oracleAddress;
    }

    function generateRandomNumber() public {
        require(oracle != address(0), "Oracle not set"); // Verifica que la dirección del oráculo no sea cero);
        randomNumber = RandomnessOracle(oracle).getRandomNumber(); // Obtiene el número aleatorio del oráculo
    }
}

