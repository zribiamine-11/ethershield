// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TimestampDependence {
    address public winner;

    // BUG: uses block.timestamp as a source of "randomness".
    // Miners/validators have some ability to influence block.timestamp
    // within a small window, letting them bias the outcome in their favor.
    function play() external payable {
        require(msg.value == 1 ether, "Must send 1 ether to play");

        if (block.timestamp % 2 == 0) {
            winner = msg.sender;
            payable(msg.sender).transfer(address(this).balance);
        }
    }

    receive() external payable {}
}