// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './PriceConverter.sol';

error NotOwner();
error CallFailed();

contract FundMe {
    using PriceConverter for uint256;

    /* Using constant reduces gas. */
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    // Using the video for reference, this is how much is saved with this gas optimization
    // Cost:
    //21,415 gas - w/ constant
    //23,515 gas - non-constant
    // Eth Math:
    // 21,415 * 141000000000 = $9.058545
    // 23,515 * 141000000000 = $9.946845
    // Multiply the cost of gas with the current gas price on eth (lowest in this case)
    // Gas optimization matters a lot more on expensive networks like eth vs something like Polygon.

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;
    // 21,508 gas - immutable
    // 23,644 gas - non-immutable

    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable{
        require(msg.value.getConversionRate() >= MINIMUM_USD, "Didn't send enough!");
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
        // require(callSuccess, "Call Failed");
        if (!callSuccess) { revert CallFailed(); }
    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not owner!");
        if (msg.sender != i_owner) { revert NotOwner(); }
        _;
    }

    // What if someone sends this contract eth without calling the fund function?
    // We can set up receive and fallback and the code/function we want to call to handle
    // that type of event. 

    receive() external payable {
        fund();
    } 

    fallback() external payable {
        fund();
    }

}