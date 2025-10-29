// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract DenialServicesOptimizado {
    uint256 constant MAX_ITERATION = 100;

    function perfonmDos(uint256 _iterations) public pure {
        require(_iterations <= MAX_ITERATION, "Max iterations exceeded");

        uint256[] memory data = new uint256[](_iterations);
        for (uint256 i = 0; i < _iterations; i++) {
            data[i] = i;
        }
    }
}        

/*for (uint256 i = 0; i < _iterations; i++) 
        {
            uint256[] memory data = new uint256[](_iterations);
            
            for (uint256 j = i; j < _iterations; j++) {
                data[j] = j;
            }
        }
    }
*/