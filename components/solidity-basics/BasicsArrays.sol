// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract BasicArrays {

    uint256 public aNormalNumber;
    /* struct appears to be a constructor and fast creation of a class. When creating the person
    object, I am defining the parameters of the People class using the struct as my interface */
    People public person = People({favoriteNumber: 2, name: "Alex"});

    struct People {
        uint256 favoriteNumber;
        string name;
    }

    /* Array examples */
    uint256[] public numberList;
    People[] public peopleList;
    // You can specify how many objects can exist in an array by writing it like so.
    // People[3] public peopleList; //This says you must have 3 People objects in this array.

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        People memory newPerson = People({favoriteNumber: _favoriteNumber, name: _name});
        peopleList.push(newPerson);

        // You can condense 24 and 25 into - peopleList.push(People(_favoriteNumber, _name));
        // What you want to consider is that you are being less explicit with type casting.
    }

    function createPeople() public{
        addPerson({_name: "Alex", _favoriteNumber: 34});
    }

    /* Referencing the addPerson function, let's learn about "memory" */
    /* There are 6 places to store data with Solidity, these places are... */
    // 1. Stack
    // 2. Memory
    // 3. Storage
    // 4. Calldata
    // 5. Code
    // 6. Logs

    /* Focusing on calldata, memory, and storage for now. Calldata and memory only exist temporarily when
    our addPerson function is called. Storage variables exist outside our function in our contract. An 
    example would be our aNormalNumber variable on line 7. */
    /* calldata = temporary variables that can't be modified, memory = temporary variables that can be 
    modified, storage = permenant variables that can be modified.  */
    /* You cannot say a variable is a stack, code, or log */
    /* When using a string with a function, you must specify it with memory or callback. That is because
    a string is a byte array behind the scenes and that is how it is compiled. You cannot write our 
    addPerson function without using memory or callback */

}