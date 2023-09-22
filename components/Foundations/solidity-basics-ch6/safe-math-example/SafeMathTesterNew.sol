// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SafeMathTester {
    uint8 public bigNumber = 255; // checked , default as of v.0.7.6, we will see why this matters later

    function add() public { // unchecked is more gas efficient as long as your math never reaches the top or bottom limits of a number
        unchecked {bigNumber = bigNumber + 1;}
    }
}