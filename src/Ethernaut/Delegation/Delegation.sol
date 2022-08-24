// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10;
import "forge-std/console.sol";

contract Delegate {

  address public owner;

  constructor(address _owner) {
    owner = _owner;
  }

  function pwn() public {
    console.log("pwn called");
    owner = msg.sender;
  }
}

contract Delegation {

  address public owner;
  Delegate delegate;

  constructor(address _delegateAddress) {
    delegate = Delegate(_delegateAddress);
    owner = msg.sender;
  }

  fallback() external {
    console.log("fallback called");
    // console.logBytes(msg.data);
    // console.log("delegate");
    // console.log("address(delegate)");
    // console.log(address(delegate));
    // console.log("delegate.owner()");
    // console.log(delegate.owner());
    // console.log("owner");
    // console.log(owner);
    (bool result, bytes memory returnedData) = address(delegate).delegatecall(msg.data);
    // console.log(result);
    // console.logBytes(returnedData);
    if (result) {
      this;
    }
  }
}