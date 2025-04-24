// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {GiveAway} from "../src/GiveAway.sol";

contract GiveAwayTest is Test {
    // contract instace
    GiveAway public giveaway;

    // Create 2 accounts player1 and player2
    address private player1 = address(0xa);
    address private player2 = address(0xb);
    address private player3 = address(0xc);
    address private player4 = address(0xd);

    // funtion setup is deployment
    function setUp() public {
        giveaway = new GiveAway(player1);
    }

    function test_deployment() public view {
        assertEq(giveaway.name(), "Fitech");
        assertEq(giveaway.owner(), player1);
        assertEq(giveaway.symbol(), "FIT");
    }

    function test_participate() public {
        uint256 player_2_bal_b4 = giveaway.balanceOf(player2);
        vm.prank(player2); //this line makes player2 the msg.sender
        giveaway.participate();

        uint256 player_2_bal_after = giveaway.balanceOf(player2);

        assertEq(player_2_bal_b4, 0);
        assertEq(player_2_bal_b4, 0);
        assertEq(player_2_bal_after, (player_2_bal_b4 + 10000));
    }

    function test_participate_again() public {
        vm.prank(player2); //this line makes player2 the msg.sender
        giveaway.participate();

        vm.prank(player3); //this line makes player3 the msg.sender
        giveaway.participate();

        vm.prank(player4); //this line makes player3 the msg.sender
        vm.expectRevert();
        giveaway.participate();
    }
}
