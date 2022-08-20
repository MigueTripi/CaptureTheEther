pragma solidity ^0.8.10;
// pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "forge-std/console.sol";
import "./Force.sol";
import "./ForceFactory.sol";
import "./ForceHacker.sol";
import "../Ethernaut.sol";

contract ForceTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    Ethernaut ethernaut;
    address eoaAddress = address(100);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        ethernaut = new Ethernaut();
        // Deal EOA address some ether
        vm.deal(eoaAddress, 5 ether);
    }

    function testForceHack() public {

        /////////////////
        // LEVEL SETUP //
        /////////////////

        ForceFactory forceFactory = new ForceFactory();
        ethernaut.registerLevel(forceFactory);
        vm.startPrank(eoaAddress);

        address levelAddress = ethernaut.createLevelInstance(forceFactory);
        Force ethernautForce = Force(payable(levelAddress));

        /////////////////
        // LEVEL HACK  //
        /////////////////

        ForceHacker hacker = new ForceHacker{value: 1000 wei}(address(ethernautForce));
        
        hacker.attack();
        uint256 balance =  payable(address(ethernautForce)).balance;
        console.log(balance);
        assertEq(balance, 1000 wei);        

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        vm.stopPrank();
        assert(levelSuccessfullyPassed);

        //forge test --match-path src/Ethernaut/Force/ForceTest.t.sol -vvvv
  }
}
