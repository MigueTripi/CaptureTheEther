// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import '../BaseLevel.sol';
import './Delegation.sol';
import "forge-std/console.sol";
contract DelegationFactory is Level {

  address delegateAddress;

  constructor() {
    Delegate newDelegate = new Delegate(address(0));
    delegateAddress = address(newDelegate);
  }

  function createInstance(address _player) override public payable returns (address) {
    _player;
    Delegation parity = new Delegation(delegateAddress);
    return address(parity);
  }

  function validateInstance(address payable _instance, address _player) override public returns (bool) {
    console.log("validateInstance");
    Delegation parity = Delegation(_instance);
    console.log(_instance);
    console.log(_player);
    console.log(parity.owner());
    return parity.owner() == _player;
  }
}