// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import {LibAppStorage} from "../libraries/LibAppStorage.sol";

contract SetEmail {
    LibAppStorage.Layout layout;

    function setEmail(string memory _email) external {
        layout.email = _email;
    }

    function getLayout1() public view returns (LibAppStorage.Layout memory l) {
        l.number = layout.number;
        l.name = layout.name;
        l.email = layout.email;
    }
}
