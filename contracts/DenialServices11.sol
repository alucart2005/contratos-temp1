// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract OverflowUnderflow {
    function overLowExample(uint256 _val) public pure returns (uint8) {
        uint8 maxValue = 255;
        maxValue += _val;
        return maxValue;
    }

    function underLowExample(uint256 _val) public pure returns (uint8) {
        uint8 minValue = 0;
        minValue -= _val;
        return minValue;
    }
}