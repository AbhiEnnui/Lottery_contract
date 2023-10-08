// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Demon {

    address public sakuna;
    address payable [] public toys;

    constructor() {
        sakuna = msg.sender;
    }

    receive() external payable { 
        require(msg.value>1 ether);
        toys.push(payable(msg.sender));
    }

    function soul() public view returns (uint){
        require(msg.sender==sakuna);
        return address(this).balance;
    }


    function random() public  view returns(uint) {
    return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, toys.length)));
}

    function selectwinner() public{
        require(msg.sender==sakuna);
        require(toys.length>=3);
        uint r = random();
        address payable winner;
        uint index = r % toys.length;
        winner = toys[index];
        winner.transfer(soul());
        toys= new address payable [](0);

    }
    
}