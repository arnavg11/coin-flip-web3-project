// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract flip{
    address owner;
    string public result = "waiting on user to flip coin...";
    constructor(){
        owner = msg.sender;
    }
    function fill() public payable {

    }
    modifier isOwner(){
        require(msg.sender==owner);
        _;
    }
    function getRes() public view returns(string){
        return result;
    }
    uint min = 1 wei;
    event flipResult(
        uint stake,bool res
    );
    function bet() public payable {
         require(msg.value >= min && msg.value<=address(this).balance);
         uint r = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, block.number)))%2;
         bool state = r == 1; 
         emit flipResult(msg.value,state);
         if(state){
            result = "user won ";
             payable(msg.sender).transfer(2*msg.value);
         }else {
            result = "user lost "+(string)msg.value;
             payable(owner).transfer(msg.value);
         } 
    }
}
