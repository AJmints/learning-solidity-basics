// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import '@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol';
/* npm install @chainlink/contracts --save
This npm command brought in our Chainlink package. 
View notes on bottom to see our order of opperation.*/

contract FundMe {

    // We need to convert our usd amount to have appropriate decimal places.
    uint256 public miniumUsd = 50 * 1e18; // 1 * 10 ** 18

    function fund() public payable{
        // Since we defined our getConversionRate function, we can use it here to 
        // make sure our eth is greater than || equal to our usd amount we are sending.
        require(getConversionRate(msg.value) >= miniumUsd, "Didn't send enough!");
        // msg.value has 18 decimals (wei)
    }

    function getPrice() public view returns(uint256) {
        // Things we need - ABI, Address
        //address 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        /* (uint80 roundId, int256 price, uint startedAt, uint timeStamp, uint80 answeredInRound)
        our variable below has been shortend, but previously looked like the code above. */
        (,int256 price,,,) = priceFeed.latestRoundData();
        // We are getting the value of ETH in USD
        // With this certain price feed, 300000000000 has 8 decimal points, so it being read as 3000.00000000
        return uint256(price * 1e10); // 1**10 === 10000000000 This is some of the money math we will eventually memorize.

    }

    /* This is an example method using the AggregatorV3Interface */
    function getVersion() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {
        uint256 ethPrice = getPrice(); // Get the price of Ethereum
        // Example 3000.000000000000000000 = Eth / Usd price (Eth measured in wei)
        // 1.000000000000000000 Eth 
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // Always multiply before you divide.
        // ethAmountInUsd = $3000 usd
        return ethAmountInUsd;
    }

    // function withdraw() {}

}

/* First step is to convert msg.value into a usd value vs the layer 1 value (eth, avax, sol, etc)
We then write a getPrice function and getConversionRate function. 

2. Get Chainlink - Ethereum data feeds contract address so we can find a conversion rate
You can find the link to the contract here... 

We are using the Goerli testnet address, though the video is using Rinkby (not available anymore.)
Address: ETH/USD 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
URL: https://docs.chain.link/data-feeds/price-feeds/addresses/?network=ethereum&page=1

3. We copy/pasted an interface from a chainlink github repo that we are going to be using for
this demo. The link to the repo we used is located below.
URL: https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol
 */