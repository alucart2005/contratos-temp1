// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

contract Inmutable {
    /* Establece el valor de la variable inmutable en el momento de la implementación
    transaction cost	43573 gas 
    execution cost	22509 gas  
    */
    // address public immutable owner = msg.sender; 
    /* sin immutable:
    transaction cost	45708 gas 
    execution cost	24644 gas 
    */
    address public owner; 
    uint public x;

    constructor (){
        owner =msg.sender;
    }

    function foo() external {
        require(msg.sender == owner);
        x += 1;
    }

}
