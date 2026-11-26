// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract IntegerOverflow {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    // BUG: deliberately wrapped in `unchecked`, disabling Solidity 0.8+'s
    // built-in overflow/underflow protection. Without `unchecked`, this
    // exact same line would safely revert instead of wrapping around.
    function withdraw(uint256 amount) external {
        unchecked {
            balances[msg.sender] -= amount; // can underflow to a huge number
                                             // if amount > balance
        }
        payable(msg.sender).transfer(amount);
    }
}