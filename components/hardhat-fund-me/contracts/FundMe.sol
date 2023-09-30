// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './PriceConverter.sol';

error NotOwner();
error CallFailed();

contract FundMe {
    using PriceConverter for uint256;

    /* Using constant reduces gas. */
    uint256 public constant MINIMUM_USD = 50 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    /* Updated constructor, added this new variable, and refactored PriceConverter to adapt to any chain we are on */
    /* This variable uses the AggregatorV3Interface to make our contract variable and modularized for the chain we are connected to */
    AggregatorV3Interface public priceFeed;

    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    function fund() public payable{
        require(msg.value.getConversionRate(priceFeed) >= MINIMUM_USD, "Didn't send enough!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value; 
    }

    function withdraw() public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) { 
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address[](0);
        
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        if (!callSuccess) { revert CallFailed(); }
    }

    modifier onlyOwner {
        if (msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    // If someone sends this contract eth - handled by receive and fallback
    receive() external payable {
        fund();
    } 

    fallback() external payable {
        fund();
    }

}