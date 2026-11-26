// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableTxOrigin {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    // BUG: uses tx.origin instead of msg.sender for authentication
    function withdrawAll() external {
        require(tx.origin == owner, "Not owner");
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {}
}