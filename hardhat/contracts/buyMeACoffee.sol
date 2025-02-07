// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;

contract BuyMeACoffee {

    //memo struct
    struct Memos {
        address from;
        uint256 timestanp;
        string name;
        string message; 
    }
    
    //newMemo event
    event newMemo( address indexed from, uint256 timestamp, string name, string message);

    address payable owner;
    Memos[] memos;
    constructor() {
        owner = payable(msg.sender);
        
    }
    //fetch memos
    function fetchMemos() public view returns (Memos[] memory) {
        return memos;
    }


    //buy me a coffee function
    function buyMeACoffee(string memory _name, string memory _message) public payable {
        require(msg.value >= 0.01 ether, "Minimum 0.01 ether required");

        //create new memo
        Memos memory memo = Memos(msg.sender, block.timestamp, _name, _message);

        // add memo to memos array
        memos.push(memo);

        //emit new memo event
        emit newMemo(msg.sender, block.timestamp, _name, _message);
        owner.transfer(msg.value);
    }

    //withdraw funds
    function withdraw() public {
        require(msg.sender == owner, "Only owner can withdraw funds");
        payable(msg.sender).transfer(address(this).balance);
    }
    //jds
   
}