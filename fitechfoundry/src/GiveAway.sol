// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.22;

import {ERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ReentrancyGuard} from "lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol";
import {Ownable} from "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract GiveAway is ERC20, Ownable, ReentrancyGuard {
    uint256 public price_pool = 100_000;
    uint256 public rewardAmount = 10_000;
    uint8 public winners;
    mapping(address => bool) public winner;
    mapping(address => bool) public won;

    constructor(
        address initialOwner
    ) ERC20("Fitech", "FIT") Ownable(initialOwner) {}

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function participate() external nonReentrant {
        require(winners < 2, "bounty have been exhausted");
        require(!won[msg.sender], "Already won");
        require(price_pool >= rewardAmount, "reward have been exhausted");
        price_pool -= rewardAmount;
        won[msg.sender] = true;
        winners++;
        _mint(msg.sender, rewardAmount);
    }

    function checkWinner(address _addr) public view returns (bool) {
        return winner[_addr];
    }
}
