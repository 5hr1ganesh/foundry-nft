// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "lib/forge-std/src/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

contract MintBasicNft is Script {
    string public constant FanCat =
        "https://bafybeicf6xfwvv2tgrysdpqzdjyxb74idjd7tf5hv47cd7fdjghq7cyhwm.ipfs.dweb.link?filename=enchanted-rainbow-cat.json";

    // address public ganesh = 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266;

    function run() external {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid
        );
        minNftOnContract(mostRecentlyDeployed);
    }

    function minNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(FanCat);
        vm.stopBroadcast();
    }
}

contract MintMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        mintNftOnContract(mostRecentlyDeployedMoodNft);
    }

    function mintNftOnContract(address contractAddress) public {
        vm.startBroadcast();
        MoodNft(contractAddress).mintNft();
        vm.stopBroadcast();
    }
}

contract FlipMoodNft is Script {
    function run() external {
        address mostRecentlyDeployedMoodNft = DevOpsTools
            .get_most_recent_deployment("MoodNft", block.chainid);
        flipMoodNftOnContract(mostRecentlyDeployedMoodNft, 0);
    }

    function flipMoodNftOnContract(
        address contractAddress,
        uint256 tokenId
    ) public {
        vm.startBroadcast();
        MoodNft(contractAddress).flipMood(tokenId);
        vm.stopBroadcast();
    }
}
