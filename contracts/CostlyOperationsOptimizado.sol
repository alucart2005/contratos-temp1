// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract CostlyOperations {
    uint256 constant public MAX_ITERATIONS = 1600;

    function performCostlyOperators() pure external returns (uint256 result){
        result = 0;

        for (uint256 i = 0; i < MAX_ITERATIONS; i++) {
            result += 1;
        }
    }
}