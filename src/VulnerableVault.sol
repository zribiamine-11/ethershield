// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableVault {
    mapping(address => uint256) public balances;

    // Deposit ETH into the vault
    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // Withdraw your full balance
    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "No balance to withdraw");

        // BUG: sends ETH BEFORE updating the balance.
        // This allows a malicious contract to call withdraw() again
        // during the external call, before balances[msg.sender] is reset.
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] = 0; // updated too late
    }

    // Helper to check the vault's total ETH balance
    function vaultBalance() external view returns (uint256) {
        return address(this).balance;
    }
}