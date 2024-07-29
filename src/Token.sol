//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.23;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
    address public owner;
    error onlyOwnerAllowed(address);

    constructor(uint256 totalSupply) ERC20("Token", "TK") {
        _mint(msg.sender, totalSupply);
        owner = msg.sender;
    }

    function burn(address account, uint amount) public returns (uint) {
        require(account == owner, "cannot destroy user's assets");
        if (msg.sender != owner) {
            revert onlyOwnerAllowed(owner);
        }
        _burn(account, amount);
        return amount;
    }

    // Getter
    function getOwner() external view returns (address) {
        return owner;
    }
}
