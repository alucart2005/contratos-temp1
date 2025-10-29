// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract DenialServices {
    function perfonmDos(uint256 _iterations) public pure {
        for (uint256 i = 0; i < _iterations; i++) 
        {
            uint256[] memory data = new uint256[](_iterations);
            
            for (uint256 j = i; j < _iterations; j++) {
                data[j] = j;
            }
        }
    }
}