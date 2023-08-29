// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract BasicMapping {

    /* Mapping is a data structure where a key mapped to a single value. */
    /* So with this method, we are essentially making key value pairs and storing 
    them inside this mapping structure (which, from what I can tell is acting like
    an array) */
    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    uint256[] public numberList;
    People[] public peopleList;

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        peopleList.push(People(_favoriteNumber, _name));
        /* any time this function is called, we are adding a key value pair to our 
        mapping data structure along with our array that is being used above on ln22 */
        nameToFavoriteNumber[_name] = _favoriteNumber; 
    }

}