pragma solidity ^0.8.10;
// pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "forge-std/console.sol";
import "./BalanceManager.sol";
import "./BalanceManagerHacker.sol";

contract BalanceManagerTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    address eoaAddress = address(10);
    BalanceManager manager;
    BalanceManagerHacker hacker;

    function setUp() public {
        // Setup instance of the Ethernaut contract
        vm.deal(eoaAddress, 5 ether);
        // Deal EOA address some ether
        manager = new BalanceManager(eoaAddress);
        hacker = new BalanceManagerHacker(manager);
    }


function testHackTheContract() public {

    bytes memory bytecode = abi.encodePacked(vm.getCode("BalanceManagerHacker.sol"));
    address hackerCode;
    assembly {
        hackerCode := create(0, add(bytecode, 0x20), mload(bytecode))
    }
    vm.startPrank(eoaAddress);
    //BalanceManager(hacker).setNewBalance(eoaAddress, 0);
    hackerCode.call(abi.encodeWithSignature("setNewBalance(address, uint256)", eoaAddress, 1));
    (bool successSet, bytes memory storedAnswer) = hackerCode.call(abi.encodeWithSignature("getBalance(address)", eoaAddress));
    // (, bytes memory isTrue) = hackerCode.call(abi.encodeWithSignature("isTrue()"));
    
    // (bool successIsComplete, bytes memory isComplete) = hackerCode.call{value: 1 ether}(abi.encodeWithSignature("isComplete()"));

    console.log(successSet);
    console.log("storedAnswer");
    console.logBytes(storedAnswer);
    assertEq(uint(bytes32(storedAnswer)), 1);   

        vm.stopPrank();
  }
        //forge test --match-path src/contracts/pocs/DropBalance/BalanceManagerTest.t.sol -vvvv

}
