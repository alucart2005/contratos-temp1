// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

interface ICounter {
    function count() external view returns (uint); 
    function inc() external;
    function dec() external;
}

contract CallInterfaces {
    uint public count;

    function exampleInc(address _counter) external {
        ICounter(_counter).inc();
        count = ICounter(_counter).count();
    }
    function exampleDec(address _counter) external {
        ICounter(_counter).dec();
        count = ICounter(_counter).count();
    }
}