// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

contract FundFundMe is Script{
    uint256 constant SEND_VALUE = 0.01 ether;

    function fundFundMe(address mostRecentDeployed) public {
vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).fund{value: SEND_VALUE}();
        console.log("Funded FundMe contract ", SEND_VALUE);
        vm.stopBroadcast();
    }


    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe", block.chainid
        );
        // vm.startBroadcast();
        fundFundMe(mostRecentlyDeployed);
        // vm.stopBroadcast();
    }


}

contract WithdrawFundMe is Script{
     function withdrawFundMe(address mostRecentDeployed) public {
vm.startBroadcast();
        FundMe(payable(mostRecentDeployed)).withdraw();
vm.stopBroadcast();
    }


    function run() external{
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "FundMe", block.chainid
        );
        // vm.startBroadcast();
        withdrawFundMe(mostRecentlyDeployed);
        // vm.stopBroadcast();

    }
}