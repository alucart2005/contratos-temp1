// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

library SafeMath {
    // Suma segura
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: suma con overflow");
        return c;
    }
    
    // Resta segura
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: resta con underflow");
        return a - b;
    }
    
    // Multiplicación segura
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) return 0;
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplicacion con overflow");
        return c;
    }
    
    // División segura
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division por cero");
        return a / b;
    }
    
    // Módulo seguro
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: modulo por cero");
        return a % b;
    }
}