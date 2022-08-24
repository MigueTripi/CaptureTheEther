// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/console.sol";

contract BalanceManager {

    mapping(address => uint256) private balances;  

    constructor(address _balanceAddress) {
        balances[_balanceAddress] = 100;
    }

    function setNewBalance(address _address, uint256 _newBalance) private {
        balances[_address] = _newBalance;
        console.log("setNewBalance BalanceManager");
        console.log(_newBalance);
    }

    function getBalance(address _address) public view returns(uint256) {
        console.log("getBalance BalanceManager");
        return balances[_address];
    }
}