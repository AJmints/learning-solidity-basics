// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FundMe {

    uint256 public number;

    /* In order to make a function able to make a function payable, you have to add 
    the "payable" keyword to your function.  */
    function fund() public payable{

        /* msg.value is how you would get the amount ethereum is being sent. */
        /* When we use "require", we can specify the minimum amount of ethereum
        that needs to be sent. */
        /* Money math is done in terms of wei. So 1 Ethereum needs to be set as 
        1e18 value. In our require conditional, we are saying that minimum value
        being sent must at least equal 1Eth. If we don't have at least 1Eth being 
        sent, we have our error message print instead. */
        number = 5;
        require(msg.value >= 1e18, "Didn't send enough!"); // 1e18 = 1 * 10 ** 18 == 1000000000000000000 (wei)
        
        /* If our conditional in require is returned false, we get reverting */
        /* Reverting - undo any action before, and send remaining gas back */
        /* If our fund function is called and require returns false, then it would 
        effect the number variable. When the function reverts, any code that would have
        run gets reverted back to it's previous state. So number wouldn't be assigned a
        value. However, since number is being compiled before we check the require conditional,
        it would still cost a certain amount of gas to assign and reassign the number 
        variable. So This transaction would still cost some gas to execute, even though it 
        didn't go through. */

    }

    // function withdraw() {}
}