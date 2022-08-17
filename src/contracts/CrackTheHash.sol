pragma solidity ^0.4.21;

contract CrackTheHash {
    bytes32 hashToCrack = 0xdb81b4d58595fbbbb592d3661a34cdca14d7ab379441400cbfa1b78bc447c365;

    function findTheSourceValue() public view returns (uint8) {
        for(uint8 i = 0; i <= 255; i++ ){
            if (keccak256(i) == hashToCrack)
                return i;
        }
    }

    function toKeccak256(uint8 value) public pure returns (bytes32){
        return keccak256(value);
    }
}