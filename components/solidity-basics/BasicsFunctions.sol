// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract BasicFunctions {

    /* favoriteNumber is initialized to 0 by default. */
    /* If public is not declared, then the default is run as internal. */
    uint256 public favoriteNumber;
    // uint256 favoriteNumber;

    /* Visibility specifiers */
    // public, private, external, internal, and probably more to learn later. 

    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    /* Any time a function is run, it makes a call to the blockchain and costs gas to run the transaction */
    /* Early Speculation: We write functions that take a parameter and when we send them to the network,
    we are changing the state on the Ethereum blockchain. In this example, I would enter a number from a 
    UI that would fill in the parameter in the store function and when I submit that form, it would
    execute and change the state of the blockchain and cost gas for me to run that transaction. 
    If I were to inquire about the state of a variable (with public specifier), it would be like using
    a getter that still costs gas to get that info from the blockchain. */

    /* The more complex a function is, the more expesive gas wise it will become. */


    /* view, pure */
    /* view, pure */
    /* view, pure */

    /* View and Pure funcitons, when called alone, don't spend gas */
    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    /* any function marked with view will read the state of the contract */
    /* A view and pure function disallow modifications of state */
    /* A view function can't update the state of the blockchain */
    /* Pure functions additionally disallow you to read from blockchain state */

    //Pure example
    function add() public pure returns(uint256) {
        return(1+1);
    }
    /* In this example, we would be using a pure function to perform repititious math problems or run
    specific algorithims that doesn't need to read any state. */
    /* If a view/pure function are called inside another function that does interact with the blockchain,
    then it would cost gas because you are adding onto the computational load.  */

}