// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableAuction {
    address public highestBidder;
    uint256 public highestBid;

    // BUG: bid amount is public in the mempool before being mined,
    // so an attacker can see a pending bid and front-run it with a slightly higher one
    function bid() external payable {
        require(msg.value > highestBid, "Bid too low");

        if (highestBidder != address(0)) {
            payable(highestBidder).transfer(highestBid);
        }

        highestBidder = msg.sender;
        highestBid = msg.value;
    }
}