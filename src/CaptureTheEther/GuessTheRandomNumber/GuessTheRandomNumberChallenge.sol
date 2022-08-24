pragma solidity ^0.8.0;

contract GuessTheRandomNumberChallenge {
    uint8 answer;

    constructor() payable {
        require(msg.value == 1 ether);
        answer = uint8(uint((keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp)))));
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function isTrue() public pure returns (bool) {
        return true;
    }

    function getAnswer() public view returns (uint8) {
        return answer;
    }

    function guess(uint8 n) public payable {
        require(msg.value == 1 ether);

        if (n == answer) {
            payable(msg.sender).transfer(2 ether);
        }
    }
}