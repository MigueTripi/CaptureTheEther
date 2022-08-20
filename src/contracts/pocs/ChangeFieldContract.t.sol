pragma solidity ^0.8.10;

import "ds-test/Test.sol";
import "forge-std/Vm.sol";
import "forge-std/Console.sol";
import "./ChangeFieldContract.sol";


contract ChangeFieldTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    ChangeFieldContract challengeContract;

    function setUp() public {
        // Setup instance of the challengeContract
        challengeContract = new ChangeFieldContract();
        console.log("setup finished");
    }

    function testChangeTheNumber() public {

    //Get the bytes of the code.
    console.log("Before getCode");
    bytes memory bytecode = abi.encodePacked(vm.getCode("ChangeFieldContract.sol"));
    address challengeCode;
    console.log("after getCode");
    console.log(block.number);
    vm.roll(5);
    console.log(block.number);
    console.log(block.timestamp);
    // Deploy the contract sending the code we got in the previous step. This way as it only works with 0.5.0 solidity version
    assembly {
        challengeCode := create(0, add(bytecode, 0x20), mload(bytecode))
    }

    //Set the msg.sender of each interaction with the contract.
    vm.startPrank(tx.origin);

    // Make contract first to get the initial value
    (bool successGet, bytes memory firstValue) = challengeCode.call(abi.encodeWithSignature("getField()"));
    assert(successGet);
    assertEq(uint256(bytes32(firstValue)), 0);
    
    // initializate new value
    uint8 newValue = 10;

    // Set the new value to the contract
    (bool successSet,) = challengeCode.call(abi.encodeWithSignature("setField(uint8)", newValue));
    assert(successSet);
    
    //Get the value. It must be equals to the newValue set in the previour step.
    (bool successFinalGet, bytes memory secondValue) = challengeCode.call(abi.encodeWithSignature("getField()"));
    assert(successFinalGet);
    assertEq(uint256(bytes32(secondValue)), 10);
    (, bytes memory isTrue) = challengeCode.call(abi.encodeWithSignature("isTrue()"));
    console.logBytes(isTrue);

    //To test only this:
    //forge test --match-path src/contracts/pocs/ChangeFieldContract.t.sol -vv
    
    }

}
