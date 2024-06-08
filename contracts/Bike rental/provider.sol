// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BikeProvider {
    address public owner;
    uint256 public bikePrice;
    mapping(address => bool) public rentedBikes;

    event BikeRented(address indexed customer, uint256 timestamp);

    constructor(uint256 _bikePrice) {
        owner = msg.sender;
        bikePrice = _bikePrice;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function rentBike(address _customer) external onlyOwner {
        require(!rentedBikes[_customer], "Bike already rented to this customer");
        rentedBikes[_customer] = true;
        emit BikeRented(_customer, block.timestamp);
    }

    function returnBike(address _customer) external onlyOwner {
        require(rentedBikes[_customer], "No bike rented to this customer");
        rentedBikes[_customer] = false;
    }
}
