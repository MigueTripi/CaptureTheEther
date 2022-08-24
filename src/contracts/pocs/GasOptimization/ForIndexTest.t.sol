pragma solidity ^0.8.10;
// pragma solidity ^0.6.0;

import "ds-test/test.sol";
import "forge-std/vm.sol";
import "forge-std/console.sol";
import "./ForIndex.sol";

contract ForIndexTest is DSTest {
    Vm vm = Vm(address(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D));
    address eoaAddress = address(10);

    function setUp() public {
        // Setup instance of the Ethernaut contract
        // vm.startPrank(address(1));
        vm.deal(eoaAddress, 5 ether);
        // Deal EOA address some ether
    }

    function testDelegationHack() public {


        /////////////////
        // LEVEL HACK  //
        /////////////////
        ForIndex aContract = new ForIndex();
        aContract.FirstSymbol();
        aContract.SymbolLast();      

        vm.stopPrank();
        //forge test --match-path src/contracts/pocs/GasOptimization/ForIndexTest.t.sol -vvvv
  }
}
