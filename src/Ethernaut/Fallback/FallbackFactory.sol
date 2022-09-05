
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;

import '../BaseLevel.sol';
import './Fallback.sol';
import "forge-std/console.sol";

contract FallbackFactory is Level {

  function createInstance(address _player) override public payable returns (address) {
    _player;
    Fallback instance = new Fallback();
    return address(instance);
  }

  function validateInstance(address payable _instance, address _player) override public returns (bool) {
    Fallback instance = Fallback(_instance);
    console.log("owner", instance.owner());
    console.log("player", _player);
    console.log("balance", address(instance).balance);

    return instance.owner() == _player && address(instance).balance == 0;
  }
}