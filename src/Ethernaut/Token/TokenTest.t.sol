pragma solidity ^0.8.10;
// pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "forge-std/console.sol";
import "./Token.sol";
import "./TokenHacker.sol";
import "./TokenFactory.sol";
import "../Ethernaut.sol";

contract TokenTest is DSTest {
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
        TokenFactory tokenFactory = new TokenFactory();
        ethernaut.registerLevel(tokenFactory);

        vm.startPrank(eoaAddress);
        address levelAddress = ethernaut.createLevelInstance(tokenFactory);

        /////////////////
        // LEVEL HACK  //
        /////////////////
        TokenHacker hacker = new TokenHacker(levelAddress);
        hacker.attack(eoaAddress, 21000000);

        bool levelSuccessfullyPassed = ethernaut.submitLevelInstance(payable(levelAddress));
        assert(levelSuccessfullyPassed);
        vm.stopPrank();

        //forge test --match-path src/Ethernaut/Token/TokenTest.t.sol -vvvv
  }
}
