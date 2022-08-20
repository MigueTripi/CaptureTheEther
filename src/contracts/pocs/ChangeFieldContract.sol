pragma solidity ^0.8.10;


contract ChangeFieldContract {
    uint8 field;

    function getField() public view returns(uint8){
        return field;
    }

    function setField(uint8 newValue) public {
        field = newValue;
    }

    function isTrue() public pure returns(bool){
        return true;
    }

}