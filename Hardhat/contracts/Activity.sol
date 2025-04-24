// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

contract Activity {
    uint8 wins;

    struct Winner {
        string name;
        address usersAddress;
        bool won;
    }

    mapping(address => Winner) won;

    function setName(string memory _name) public {
        require(wins < 3, "exhausted");
        Winner storage person = won[msg.sender];
        person.name = _name;
        require(!person.won, "Allow others to win ");
        person.usersAddress = msg.sender;
        person.won = true;

        wins++;
    }

    function didIwin() public view returns (bool) {
        Winner storage person = won[msg.sender];
        return person.won;
    }
}
