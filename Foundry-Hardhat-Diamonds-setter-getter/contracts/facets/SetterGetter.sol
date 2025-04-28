// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.0;
import {LibAppStorage} from "../libraries/LibAppStorage.sol";

contract SetterGetter {
    LibAppStorage.Layout layout;

    function ChangeNameAndNumber(
        uint256 _newNumber,
        string memory _newName
    ) external {
        layout.number = _newNumber;
        layout.name = _newName;
    }

    function getLayout() public view returns (LibAppStorage.Layout memory l) {
        l.number = layout.number;
        l.name = layout.name;
    }
}
