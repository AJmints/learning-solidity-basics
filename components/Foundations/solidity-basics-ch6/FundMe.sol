// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './PriceConverter.sol';

contract FundMe {
    using PriceConverter for uint256; // Using functions from PriceConverter library

    uint256 public miniumUsd = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded; 

    function fund() public payable{
        require(msg.value.getConversionRate() >= miniumUsd, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value; 
    }

    // withdraw function is so the project can access the funds
    function withdraw() public {
        /* starting index, ending index, step amount */
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) { // Normal for loop, but using funderIndex instead of i
            address funder = funders[funderIndex]; // assign selected funder to funder address var
            addressToAmountFunded[funder] = 0; // search mapping for the same address key and assign value sent to 0
        }

        funders = new address[](0); // funders = new address array with 0 objects to start

        // transfer
        payable(msg.sender).transfer(address(this).balance); // address(this).balance is the amount of eth held in this contract
        // Wrap address in payable typecasting, inside .transfer, we specify how much we want to transfer
        // if this transaction fails, it automatically reverses and throws an error (See solidity by example "sending ether")

        // send
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "send failed");
        // .send returns a boolean. If you don't handle the bool with something like require, then the transaction defaults to not reverting the transaction and the Eth is lost.

        // call
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");
    }

}