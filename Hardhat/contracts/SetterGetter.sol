// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

contract SetterGetter {
    string name;
    uint8 age;

    function setName(string memory _name) public {
        name = _name;
    }

    function setAge(uint8 _age) public {
        age = _age;
    }

    function viewName() public view returns (string memory _name) {
        _name = name;
        return _name;
    }

    function viewAge() public view returns (uint8 _age) {
        _age = age;
        return _age;
    }
}
