// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./provider.sol";

contract Customer {
    address public owner;
    address public bikeProvider;
    bool public bikeRented;

    event BikeRental(address indexed provider, uint256 timestamp);
    event BikeReturn(address indexed provider, uint256 timestamp);

    constructor(address _bikeProvider) {
        owner = msg.sender;
        bikeProvider = _bikeProvider;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function rentBike() external {
        require(!bikeRented, "Bike already rented");
        BikeProvider provider = BikeProvider(bikeProvider);
        provider.rentBike(msg.sender);
        bikeRented = true;
        emit BikeRental(bikeProvider, block.timestamp);
    }

    function returnBike() external {
        require(bikeRented, "No bike rented");
        BikeProvider provider = BikeProvider(bikeProvider);
        provider.returnBike(msg.sender);
        bikeRented = false;
        emit BikeReturn(bikeProvider, block.timestamp);
    }
}
