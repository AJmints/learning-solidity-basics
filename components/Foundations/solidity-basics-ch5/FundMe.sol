// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol';

contract FundMe {

    uint256 public miniumUsd = 50 * 1e18;

    /* To keep track of everyone who sent tokens to our contract, we can store them in an array. */
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded; // This is assigning a key/value pair with the address that called the contract as the key, and the value being the amount they sent.

    function fund() public payable{
        require(getConversionRate(msg.value) >= miniumUsd, "Didn't send enough!");
        /* Once fund is run and goes through successfully, we can then add the sender addres to our array. */
        funders.push(msg.sender);
        /* sender is the address that called the contract, that is how we can save/track that address. */
        addressToAmountFunded[msg.sender] = msg.value; // Creating new key/value pair to our mapping variable 'addressToAmountFunded'
    }

    function getPrice() public view returns(uint256) {
        // Things we need - ABI, Address
        //address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e10);
    }

    /* This is an example method using the AggregatorV3Interface to get the version of priceFeed */
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    // function withdraw() {}

}