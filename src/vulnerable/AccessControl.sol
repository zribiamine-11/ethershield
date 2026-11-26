// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableAccessControl {
    address public owner;
    bool public paused;

    constructor() {
        owner = msg.sender;
    }

    // BUG: no restriction, anyone can change the owner
    function setOwner(address newOwner) external {
        owner = newOwner;
    }

    // BUG: anyone can pause/unpause the contract
    function setPaused(bool _paused) external {
        paused = _paused;
    }

    // BUG: anyone can drain the contract's funds
    function withdrawAll() external {
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}