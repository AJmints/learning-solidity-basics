// SPDX-License-Identifier: MIT
/* This spdx is declared to remove the warning from VS code, without it, VScode will hilight a warning */

/* Simple storage example */
/* Simple storage example */
/* Simple storage example */

/* Select the version of Solidity with this syntax */
/* The caret (^) says that we can run the declared version of solidity and above */
/* If the caret isn't declared, then the compiler will run only the declared version stated */
/* To run a specific range of solidity versions you can write your code like this on the line below */
// pragma solidity >=0.8.7 <0.9.0; 
/* This line says that I can run any version between 0.8.7 - 0.9.0 */
pragma solidity ^0.8.8;

/* Define the contract */
/* Writing contract like this says that we are writting a contract, similar to writing a class in any OOP language */
contract SimpleStorage { 

    /* learning primative data types */
    // boolean, uint, int, address, bytes 
    /* uint = unsigned integer, a whole number that isn't positive or negative, just positive */
    /* int = int, a negative or whole number */

    /* Writing variables */
    // boolean
    bool hasFavoriteNumber = true;
    //uint
    uint uintExample = 123;
    // uint can be declared with specified byte count from 8 - 256. If not declared, defaults to 256
    uint256 uintExampleWithBytes = 123456;
    uint8 anotherUintExample = 123;
    /* int has similar declarations like uint with specifiying bytes */
    int intExample = -123456;
    int256 intByteExample = 12345678;
    int8 intSmallByte = 127; //127 is the max number before encountering compiler errors
    
    /* strings are primatives with solidity */
    string stringExample = "Yup, normal string, hello world!";

    /* address example, copy from metamask eth network for example */
    address myAddress = 0xF2be7416252386E537B4FBA6B95e601A86CF0Ad7;
    
    /* bytes example */
    /* bytes can only go up to 32 */
    /* If bytes number isn't declared (bytes) then it defaults to 32 */
    bytes10 favoriteBytes = "cat";
    bytes exampleBytes = "example";
    bytes32 anotherBytesExample = "Strings are just bytes";

}