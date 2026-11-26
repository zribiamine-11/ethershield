// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableRefund {
    address[] public participants;
    mapping(address => uint256) public deposits;

    function deposit() external payable {
        if (deposits[msg.sender] == 0) {
            participants.push(msg.sender);
        }
        deposits[msg.sender] += msg.value;
    }

    // BUG: if ANY recipient's call fails (e.g. a malicious contract that reverts
    // on receive), the entire loop reverts, blocking refunds for everyone
    function refundAll() external {
        for (uint256 i = 0; i < participants.length; i++) {
            address participant = participants[i];
            uint256 amount = deposits[participant];
            deposits[participant] = 0;
            (bool success, ) = participant.call{value: amount}("");
            require(success, "Refund failed"); // blocks the whole loop
        }
    }
}