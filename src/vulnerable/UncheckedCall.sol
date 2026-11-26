// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UncheckedCall {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // BUG: the return value of .call() is never checked.
    // If the transfer silently fails, the function still behaves
    // as if the withdrawal succeeded, and the balance is wiped anyway.
    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;

        msg.sender.call{value: amount}(""); // return value ignored!
        // no require(success, ...) here
    }
}