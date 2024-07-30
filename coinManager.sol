// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

error InsufficientFunds(uint256 amountIHave, uint256 amountNeeded);
event Minted(uint256 depositAmount, address forAddress);
event CoinsTransferred(address fromAddress, address toAddress, uint256 amount);

contract CoinManager {
    address public owner;
    mapping(address => uint256) private balances;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this operation.");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function mintFor(address receivingAddress, uint256 creditingAmount) public onlyOwner {
        balances[receivingAddress] += creditingAmount;
        emit Minted(creditingAmount, receivingAddress);
    }

    function sendMyCoins(address senderAddress, address receiverAddress, uint256 value) public {
        require(balances[senderAddress] >= value, "Insufficient funds.");
        balances[senderAddress] -= value;
        balances[receiverAddress] += value;
        
        emit CoinsTransferred(senderAddress, receiverAddress, value);
    }

    function getBalance(address account) public view returns (uint256) {
        return balances[account];
    }
}
