// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract OverflowUnderflow {
    function overLowExample(uint8 _val) public pure returns (uint8) {
        uint8 maxValue = 0;
        maxValue += _val;
        return maxValue;
    }

    function underLowExample(uint8 _val) public pure returns (uint8) {
        uint8 minValue = 255;
        minValue -= _val;
        return minValue;
    }
}