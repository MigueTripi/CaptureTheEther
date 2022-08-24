pragma solidity >=0.8.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "forge-std/console.sol";
import "./GuessTheRandomNumberChallenge.sol";

contract GuessTheRandomNumberTest is DSTest {
  GuessTheRandomNumberChallenge contractChallenge;
  Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
  address hackerAddress = address(100);

  function setUp() public {
    vm.deal(hackerAddress, 1 ether);
    vm.roll(5);
    contractChallenge = new GuessTheRandomNumberChallenge{value: 1 ether}();
  }

  function testHackTheContract() public {
    bytes memory bytecode = abi.encodePacked(vm.getCode("GuessTheRandomNumberChallenge.sol"));
    address challengeCode;
    assembly {
        challengeCode := create(0, add(bytecode, 0x20), mload(bytecode))
    }

    vm.startPrank(tx.origin);

    uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number -1), block.timestamp))));
    //contractChallenge.guess{value: 1 ether}(answer);
    
    challengeCode.call{value: 1 ether}(abi.encodeWithSignature("guess(uint8)", answer));
    (, bytes memory storedAnswer) = challengeCode.call(abi.encodeWithSignature("getAnswer()"));
    // (, bytes memory isTrue) = challengeCode.call(abi.encodeWithSignature("isTrue()"));
    
    // (bool successIsComplete, bytes memory isComplete) = challengeCode.call{value: 1 ether}(abi.encodeWithSignature("isComplete()"));
    console.log("answer");
    console.log(answer);
    console.log("storedAnswer");
    console.logBytes(storedAnswer);
    assertEq(uint(bytes32(storedAnswer)), 1);
  }

  function testHackTheContract2() public {

    vm.startPrank(hackerAddress);

    uint8 answer = uint8(uint256(keccak256(abi.encodePacked(blockhash(block.number -1), block.timestamp))));
    contractChallenge.guess{value: 1 ether}(answer);
    bool isComplete = contractChallenge.isComplete();
    uint8 getAnswer = contractChallenge.getAnswer();
    
    console.log(answer);
    console.log(getAnswer);
    console.log(isComplete);

    assert(isComplete);
    vm.stopPrank();
  }
}