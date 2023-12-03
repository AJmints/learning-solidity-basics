// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract SimpleStorage {

    uint256 favoriteNumber;
    
    /* the event keywork that is paired with the emit keyword */
    event storedNumber(
        uint256 indexed oldNumber,
        uint256 indexed newNumber,
        uint256 addedNumber,
        address sender
    );
    
    mapping(string => uint256) public nameToFavoriteNumber;

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    People[] public peopleList;

    /* This store function is the example for the override - inheritence example */
    function store(uint256 _favoriteNumber) public virtual {
        /* Now in smartcontract lottery lesson and just coverd the emit keyword. 
        Updated this function to save an example */
        emit storedNumber(
            favoriteNumber,
            _favoriteNumber,
            _favoriteNumber + favoriteNumber,
            msg.sender
        );
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256) {
        return favoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        peopleList.push(People(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber; 
    }

    function viewPeople() public view returns(uint256) {
        uint256 number = peopleList.length;
        return number;
    }


}