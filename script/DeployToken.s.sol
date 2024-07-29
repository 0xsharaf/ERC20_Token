//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.23;

import {Script} from "forge-std/Script.sol";
import {Token} from "src/Token.sol";

contract DeployToken is Script {
    Token token;
    uint totalSupply = 20000;

    function run() external returns (Token) {
        vm.startBroadcast();
        token = new Token(totalSupply);
        vm.stopBroadcast();
        return token;
    }
}
