//Begin
// SPDX-License-Identifier: MIT
// An example of a calling another contract
pragma solidity ^0.4.21;

interface CallMeContract{
    function callme() external;
}

contract CallExternalFunction{

    CallMeContract callContract = CallMeContract(address(0x7bB716391e56067A82A5CD9e49995df05DEe863f));
    function call() external {
        callContract.callme();
    }
}