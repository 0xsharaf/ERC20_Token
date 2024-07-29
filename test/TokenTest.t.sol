//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.23;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";
import {DeployToken} from "../script/DeployToken.s.sol";
import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestToken is Test {
    DeployToken deployer;
    Token token;
    address user = makeAddr("user");

    function setUp() external {
        deployer = new DeployToken();
        token = deployer.run();
    }

    function testTotalSupply() external {
        vm.prank(msg.sender);
        uint256 totalSupply = 20000;
        uint256 expectedSupply = token.totalSupply();

        assertEq(totalSupply, expectedSupply);
    }

    function testOwner() external {
        vm.prank(msg.sender);
        address owner = token.getOwner();
        assert(owner == msg.sender);
    }

    function testCustomError() external {
        address owner = token.getOwner();
        vm.expectRevert(
            abi.encodeWithSelector(Token.onlyOwnerAllowed.selector, owner)
        );
        vm.prank(user);
        token.burn(address(owner), 10);
    }

    function testMintToOwner() external {
        vm.prank(msg.sender);
        uint256 ownerBalance = 20000;
        // address owner = token.getOwner();
        assertEq(ownerBalance, token.totalSupply());
    }

    function testBurn() external {
        vm.prank(msg.sender);
        token.burn(msg.sender, 1000);
    }
}
