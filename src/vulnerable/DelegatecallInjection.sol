// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DelegatecallInjection {
    address public owner;
    uint256 public value;

    constructor() {
        owner = msg.sender;
    }

    // BUG: delegatecall to a user-controlled address.
    // The called contract executes in THIS contract's storage context,
    // meaning it can overwrite `owner` or `value` directly.
    function execute(address target, bytes calldata data) external {
        (bool success, ) = target.delegatecall(data);
        require(success, "Delegatecall failed");
    }
}