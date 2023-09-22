// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallBackExample {

    uint256 public result;

    // receive only works when eth is being sent to the contract outside of a defined
    // function. If data is sent along with the contract call, then we will need a 
    // different function to handle that situation. View fallback.
    receive() external payable {
        result = 1;
    }

    // fallback works if data is sent with eth, or data is sent. If only eth is sent
    // then, receive will trigger. 
    fallback() external payable {
        result = 2;
    }

    // Explainer from: https://solidity-by-example.org/fallback/
    // Ether is sent to contract?
    //      is msg.data empty?
    //           /  \
    //         yes   no
    //         /       \
    //  receive()?    fallback()
    //     /     \
    //   yes      no
    //   /         \
    // receive()  fallback()
    //              /    \ 
    //           yes      no
    //           /          \
    //      Run fallback    error

}