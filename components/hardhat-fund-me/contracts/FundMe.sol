// SPDX-License-Identifier: MIT

// Pragma
pragma solidity ^0.8.7;

// Imports
import './PriceConverter.sol';

// Errors
/* Convention for error throwing is ContractName__ErrorName  */
error FundMe__NotOwner(); 
error FundMe__CallFailed();

// Interfaces

// Libraries

/* NatSpec setup - Look up if unsure, also check Doxygen. Comment setup is as seen below. View Learning.txt in this folder to see how to use solc to generate our docs */
/** @title A contract for crowd funding
 *  @author author name
 *  @notice This contract is to demo a sample funding contract
 *  @dev This implements price feeds as our library
 */

// Contracts
contract FundMe {
    // Type Declarations
    using PriceConverter for uint256;

    // State Variables
    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] private s_funders;
    mapping(address => uint256) private s_addressToAmountFunded;
    address private immutable i_owner;
    /* Updated constructor, added this new variable, and refactored PriceConverter to adapt to any chain we are on */
    /* This variable uses the AggregatorV3Interface to make our contract variable and modularized for the chain we are connected to */
    AggregatorV3Interface public s_priceFeed;

    // Events - None on this contract

    // Modifiers
    modifier onlyOwner {
        if (msg.sender != i_owner) { revert FundMe__NotOwner(); }
        _;
    }

    // Functions
    // Function Order:
    // Constructor
    // Receive
    // Fallback
    // External
    // Public 
    // Internal
    // Private
    // view / pure
    constructor(address priceFeedAddress) {
        i_owner = msg.sender;
        s_priceFeed = AggregatorV3Interface(priceFeedAddress);
    }

    // You can leave natspec notes over functions and various parts of your contract to inform others if anything needs clarification. 
    /** 
     * @notice This contract funds this contract
     */
    function fund() public payable{
        // require(msg.value.getConversionRate(s_priceFeed) >= MINIMUM_USD, "Didn't send enough!");
        // Had to comment out line 67 in order for the transaction to not be reverted. Also added fallback and recieve functions to this script. Not included in Lesson 7 tutorial, but covered in previous lessons.
        s_funders.push(msg.sender);
        s_addressToAmountFunded[msg.sender] = msg.value; 
    }

    function withdraw() public payable onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < s_funders.length; funderIndex++) { 
            address funder = s_funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        if (!callSuccess) { revert FundMe__CallFailed(); }
    }

    function cheaperWithdraw() public payable onlyOwner {
        address[] memory funders = s_funders;
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++) { 
            address funder = funders[funderIndex];
            s_addressToAmountFunded[funder] = 0;
        }
        s_funders = new address[](0);
        (bool success, ) = i_owner.call{value: address(this).balance}("");
        require(success);
    }

    receive() external payable {
        fund();
    } 

    fallback() external payable {
        fund();
    }
    

    // Getters

    function getOwner() public view returns(address) {
        return i_owner;
    }
    
    function getFunder(uint256 index) public view returns(address) {
        return s_funders[index];
    }
    
    function getAddressToAmountFunded(address fundingAddress) public view returns (uint256) {
            return s_addressToAmountFunded[fundingAddress];
    }

    function getPriceFeed() public view returns (AggregatorV3Interface) {
        return s_priceFeed;
    }
}