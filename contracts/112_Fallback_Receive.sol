// SPDX-License-Identifier: MIT
pragma solidity >0.8.0 <0.9.0;

/*
**Fallback execution occurs when:**
- The function does not exist  
- ETH is sent directly to the contract  

**Flowchart (text version):**

1. Ether is sent to contract  
   ↓  
2. Is `msg.data` empty?  
   ├─ YES →  
   │   ↓  
   │   Does `receive()` exist?  
   │   ├─ YES → execute `receive()`  
   │   └─ NO → execute `fallback()`  
   │  
   └─ NO → execute `fallback()`
*/

contract FallBackReceive {
    fallback() external payable { }
    receive() external payable { }
}