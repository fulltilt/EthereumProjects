pragma solidity ^0.4.20;

contract Lottery {
    address public manager;
    address[] public players;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
    }
    
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(address(this).balance);
        
        players = new address[](0); // empty array
    }
    
    modifier restricted() {
        require(msg.sender == manager);
        _;  // _ is a placeholder for fxn code
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}