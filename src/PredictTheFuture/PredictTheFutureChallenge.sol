pragma solidity >=0.8.0;

contract PredictTheFutureChallenge {
    address guesser;
    uint8 guess;
    uint256 settlementBlockNumber;

    constructor () payable {
        require(msg.value == 1 ether);
    }

    function isComplete() public view returns (bool) {
        return address(this).balance == 0;
    }

    function lockInGuess(uint8 n) public payable {
        require(guesser == address(0));
        require(msg.value == 1 ether);

        guesser = msg.sender;
        guess = n;
        settlementBlockNumber = block.number + 1;
    }

    function settle() payable public {
        require(msg.sender == guesser);
        require(block.number > settlementBlockNumber);

        bytes32 aux = keccak256(abi.encodePacked(blockhash(block.number - 1), block.timestamp));
        uint8 answer = uint8(uint(aux) % 10);

        guesser = address(0);
        if (guess == answer) {
            payable(msg.sender).transfer(2 ether);
        }
    }
}