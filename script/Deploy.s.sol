// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity >=0.7.0 < 0.9.0;
pragma abicoder v2;


import "forge-std/Script.sol";
import "../src/SwapToken.sol";
import "../src/UserStorageData.sol";
contract Deploy is Script {
    function run() external {
        vm.startBroadcast();

        SwapToken swapToken = new SwapToken();
        UserStorageData userStorageData = new UserStorageData();

        console.log("SwapToken deployed to: ", address(swapToken));
        console.log("UserStorageData deployed to: ", address(userStorageData));

        vm.stopBroadcast();
    }
}
