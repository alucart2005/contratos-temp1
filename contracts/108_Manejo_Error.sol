// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

// require, revert, assert

contract Error {
uint public num = 123;

    function testRequire(uint _i) public pure {
        require(_i <= 10, "I > 10");
    }

    function testRevert(uint _i) public pure {
        if (_i > 1) {
            if (_i > 2){
                if(_i > 10){
                    revert("I > 10");
                }
            }
        }
    }

    function testAssert() public view {
        assert(num == 123);
    }

    error MyError(address caller, uint i);

    function testErrorPersonalizado(uint _i)public view {
        if (_i > 10) {
            revert MyError(msg.sender, _i);
        }
    }

}