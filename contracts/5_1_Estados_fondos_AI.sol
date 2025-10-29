// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📚 SIMPLE EXAMPLES: VIEW, PURE AND PAYABLE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

VIEW:    Reads data but does NOT modify it
PURE:    Does NOT read or modify data (only calculations)
PAYABLE: Can receive ETH (money)
*/

contract SimpleExamples {
    
    // State variable (stored on blockchain)
    uint256 public myNumber = 10;
    
    
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // 👁️ VIEW EXAMPLE
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // Only READS data, doesn't change it
    
    function seeNumber() public view returns (uint256) {
        return myNumber;  // ✅ Only reads, doesn't modify
    }
    
    
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // 🔒 PURE EXAMPLE
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // Only does calculations, doesn't read or modify data
    
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;  // ✅ Only calculates with parameters
    }
    
    
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // 💰 PAYABLE EXAMPLE
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // Can receive money (ETH)
    
    function receiveMoney() public payable {
        // This function can receive ETH
        // msg.value = amount of ETH sent
    }
    
    
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    // 📊 VISUAL COMPARISON
    // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    /*
    
    VIEW:
    ┌─────────────┐
    │  myNumber   │  ← Only READS this data
    │     10      │
    └─────────────┘
    
    PURE:
    ┌─────────────┐
    │   a + b     │  ← Only CALCULATES
    │   5 + 3     │
    │     8       │
    └─────────────┘
    
    PAYABLE:
    ┌─────────────┐
    │  💰 ETH     │  ← RECEIVES money
    │   0.5 ETH   │
    └─────────────┘
    
    */
}


// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 🎓 COMPLETE EXAMPLE WITH ALL 3 CASES
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

contract Store {
    
    // Product price
    uint256 public price = 100;
    
    // Store balance
    uint256 public balance = 0;
    
    
    // 👁️ VIEW: See the price (only reads)
    function getPrice() public view returns (uint256) {
        return price;
    }
    
    
    // 🔒 PURE: Calculate discount (only calculates)
    function calculateDiscount(uint256 _price) public pure returns (uint256) {
        uint256 discount = (_price * 10) / 100;  // 10% discount
        return _price - discount;
    }
    
    
    // 💰 PAYABLE: Buy product (receives money)
    function buy() public payable {
        require(msg.value >= price, "Insufficient funds");
        balance += msg.value;  // Stores the received money
    }
}


// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// 💡 SUMMARY FOR STUDENTS
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

/*

┌──────────┬─────────────────────┬─────────────────────────┐
│ Keyword  │   What it does      │   Real Example          │
├──────────┼─────────────────────┼─────────────────────────┤
│  view    │ Only reads data     │ Check account balance   │
│  pure    │ Only calculates     │ Add two numbers         │
│ payable  │ Receives money(ETH) │ Buy something, donate   │
└──────────┴─────────────────────┴─────────────────────────┘


🎯 SIMPLE RULES:

1. Use VIEW when you need to SEE stored data
   Example: check balance, see a price

2. Use PURE when doing CALCULATIONS without stored data
   Example: add numbers, calculate percentages

3. Use PAYABLE when your function RECEIVES money
   Example: buy, donate, deposit


⚠️ COMMON MISTAKES:

❌ function see() public view {
       myNumber = 20;  // ERROR: view cannot modify
   }

❌ function calculate() public pure {
       return myNumber;  // ERROR: pure cannot read data
   }

❌ function buy() public {  // Missing payable
       // This function CANNOT receive ETH
   }


✅ CORRECT USAGE:

// VIEW: Reading stored data
function getBalance() public view returns (uint256) {
    return balance;  // ✅ Only reading
}

// PURE: Math operations only
function multiply(uint256 a, uint256 b) public pure returns (uint256) {
    return a * b;  // ✅ Only calculating
}

// PAYABLE: Accepting payments
function deposit() public payable {
    balance += msg.value;  // ✅ Receiving ETH
}

*/