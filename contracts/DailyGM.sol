// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DailyGM {
    address public owner;
    uint256 public lastGMDay;

    event GMSent(address indexed user, uint256 day);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function sendGM() external onlyOwner {
        uint256 todayUTC = block.timestamp / 86400;
        require(todayUTC > lastGMDay, "GM already sent today");
        lastGMDay = todayUTC;
        emit GMSent(msg.sender, todayUTC);
    }

    function currentUTCDay() external view returns (uint256) {
        return block.timestamp / 86400;
    }
}
