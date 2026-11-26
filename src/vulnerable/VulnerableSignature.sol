// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract VulnerableSignature {
    using ECDSAHelper for bytes32;

    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    // BUG: no nonce, no expiration -> the same signature can be replayed forever
    function withdraw(uint256 amount, bytes memory signature) external {
        bytes32 messageHash = keccak256(abi.encodePacked(amount, msg.sender));
        bytes32 ethSignedHash = messageHash.toEthSignedMessageHash();
        address signer = ethSignedHash.recoverSigner(signature);

        require(signer == owner, "Invalid signature");
        payable(msg.sender).transfer(amount);
    }

    receive() external payable {}
}

library ECDSAHelper {
    function toEthSignedMessageHash(bytes32 hash) internal pure returns (bytes32) {
        return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", hash));
    }

    function recoverSigner(bytes32 hash, bytes memory sig) internal pure returns (address) {
        require(sig.length == 65, "Invalid signature length");
        bytes32 r;
        bytes32 s;
        uint8 v;
        assembly {
            r := mload(add(sig, 32))
            s := mload(add(sig, 64))
            v := byte(0, mload(add(sig, 96)))
        }
        return ecrecover(hash, v, r, s);
    }
}