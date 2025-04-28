// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "../contracts/interfaces/IDiamondCut.sol";
import "../contracts/facets/DiamondCutFacet.sol";
import "../contracts/facets/DiamondLoupeFacet.sol";
import "../contracts/facets/SetterGetter.sol";
import "../contracts/facets/SetEmail.sol";
import "../contracts/facets/OwnershipFacet.sol";
import "../contracts/libraries/LibAppStorage.sol";
import "forge-std/Test.sol";
import "../contracts/Diamond.sol";

contract DiamondDeployer is Test, IDiamondCut {
    //contract types of facets to be deployed
    Diamond diamond;
    DiamondCutFacet dCutFacet;
    DiamondLoupeFacet dLoupe;
    OwnershipFacet ownerF;
    SetterGetter setter;
    SetEmail setemail;

    function setUp() public {
        //deploy facets
        dCutFacet = new DiamondCutFacet();
        diamond = new Diamond(address(this), address(dCutFacet));
        dLoupe = new DiamondLoupeFacet();
        ownerF = new OwnershipFacet();
        setter = new SetterGetter();

        //upgrade diamond with facets

        //build cut struct
        FacetCut[] memory cut = new FacetCut[](3);

        cut[0] = (
            FacetCut({
                facetAddress: address(dLoupe),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("DiamondLoupeFacet")
            })
        );

        cut[1] = (
            FacetCut({
                facetAddress: address(ownerF),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("OwnershipFacet")
            })
        );

        cut[2] = (
            FacetCut({
                facetAddress: address(setter),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("SetterGetter")
            })
        );

        //upgrade diamond
        IDiamondCut(address(diamond)).diamondCut(cut, address(0x0), "");

        //call a function
        DiamondLoupeFacet(address(diamond)).facetAddresses();
        SetterGetter l = SetterGetter(address(diamond));
        l.ChangeNameAndNumber(20, "Aji");
    }

    function testSetEmail() public {
        // deploying set Email contract
        setemail = new SetEmail();

        //build cut struct
        FacetCut[] memory cut = new FacetCut[](1);

        // setter getter prepared to be added to the diamond
        cut[0] = (
            FacetCut({
                facetAddress: address(setemail),
                action: FacetCutAction.Add,
                functionSelectors: generateSelectors("SetEmail")
            })
        );

        //upgrade diamond
        //  this makes the setter getter part of the diamond
        IDiamondCut(address(diamond)).diamondCut(cut, address(0x0), "");

        //call a function
        SetEmail l = SetEmail(address(diamond));
        l.setEmail("Aji@gmail.com");
        LibAppStorage.Layout memory layout = l.getLayout1();

        assertEq(layout.name, "Aji");
        assertEq(layout.number, 20);
        assertEq(layout.email, "Aji@gmail.com");
    }

    // function testAddSetterGetterToDiamond() public {
    //     // deploying contract with setter getter logic
    //     setter = new SetterGetter();

    //     //build cut struct
    //     FacetCut[] memory cut = new FacetCut[](1);

    //     // setter getter prepared to be added to the diamond
    //     cut[0] = (
    //         FacetCut({
    //             facetAddress: address(setter),
    //             action: FacetCutAction.Add,
    //             functionSelectors: generateSelectors("SetterGetter")
    //         })
    //     );

    //     //upgrade diamond
    //     //  this makes the setter getter part of the diamond
    //     IDiamondCut(address(diamond)).diamondCut(cut, address(0x0), "");

    //     //call a function
    //     SetterGetter l = SetterGetter(address(diamond));
    //     l.ChangeNameAndNumber(20, "Aji");
    //     LibAppStorage.Layout memory layout = l.getLayout();

    //     assertEq(layout.name, "Aji");
    //     assertEq(layout.number, 20);
    // }

    function generateSelectors(
        string memory _facetName
    ) internal returns (bytes4[] memory selectors) {
        string[] memory cmd = new string[](3);
        cmd[0] = "node";
        cmd[1] = "scripts/genSelectors.js";
        cmd[2] = _facetName;
        bytes memory res = vm.ffi(cmd);
        selectors = abi.decode(res, (bytes4[]));
    }

    function diamondCut(
        FacetCut[] calldata _diamondCut,
        address _init,
        bytes calldata _calldata
    ) external override {}
}
