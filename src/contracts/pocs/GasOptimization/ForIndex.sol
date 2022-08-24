pragma solidity ^0.8.10;

import "forge-std/console.sol";

contract ForIndex  {

    function FirstSymbol() public pure {
        for (uint256 index = 0; index < 100; ++index) {
            index = index;
        }
    }

        function SymbolLast() public pure {
        for (uint256 index = 0; index < 100; index++) {
            index = index;
        }
    }
}
