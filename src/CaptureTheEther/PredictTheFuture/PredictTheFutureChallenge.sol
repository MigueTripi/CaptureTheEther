pragma solidity >=0.8.0;


/**
This time, you have to lock in your guess before the random number is generated. 
To give you a sporting chance, there are only ten possible answers.
Note that it is indeed possible to solve this challenge without losing any ether.

 */

contract PredictTheFutureChallenge {
    //0x6204a028a5143C8e4De62b09235EC811259C2A1B
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

    function getGuess() public view returns(uint8){
        return guess;
    }

    function getSettlementBlockNumber() public view returns(uint256){
        return settlementBlockNumber;
    }

    function getGuesser() public view returns(address){
        return guesser;
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