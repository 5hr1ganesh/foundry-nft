// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "lib/forge-std/src/Test.sol";
import {BasicNft} from "../../src/BasicNft.sol";
import {DeployBasicNft} from "script/DeployBasicNft.s.sol";

contract TestBasicNft is Test {
    DeployBasicNft public deployer;
    BasicNft public basicNft;
    address public USER = makeAddr("USER");
    string public constant EnchantingCat =
        "https://bafybeihtni27dknprdk6br2dqk653kyg62vtsmuzjn4deqrgexcqjtvmsq.ipfs.dweb.link?filename=enchanted-rainbow-cat.json";
    string public constant FanCat =
        "https://bafybeievtjjptwbyb6ksbbuonljvqmn3qehfe22bw7veeii3xdloy22qca.ipfs.dweb.link?filename=fantasy-creature-with-butterfly.json";

    function setUp() public {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Catyo";
        string memory actualName = basicNft.name();
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveBalance() public {
        vm.prank(USER);
        basicNft.mintNft(FanCat);

        assert(basicNft.balanceOf(USER) == 1);
        assert(
            keccak256(abi.encodePacked(FanCat)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }

    function testTokenUri() public {
        vm.prank(USER);
        basicNft.mintNft(EnchantingCat);
        string memory tokenUri = basicNft.tokenURI(0);

        assert(
            keccak256(abi.encodePacked(EnchantingCat)) ==
                keccak256(abi.encodePacked(tokenUri))
        );
    }

    function testMultipleTokenUris() public {
        vm.prank(USER);
        basicNft.mintNft(EnchantingCat);
        vm.prank(USER);
        basicNft.mintNft(FanCat);

        string memory tokenUri1 = basicNft.tokenURI(0);
        string memory tokenUri2 = basicNft.tokenURI(1);

        assert(
            keccak256(abi.encodePacked(EnchantingCat)) ==
                keccak256(abi.encodePacked(tokenUri1))
        );

        assert(
            keccak256(abi.encodePacked(FanCat)) ==
                keccak256(abi.encodePacked(tokenUri2))
        );
    }

    function testMultipleTokenUrisWithDifferentUsers() public {
        vm.prank(USER);
        basicNft.mintNft(EnchantingCat);
        vm.prank(USER);
        basicNft.mintNft(FanCat);

        string memory tokenUri1 = basicNft.tokenURI(0);
        string memory tokenUri2 = basicNft.tokenURI(1);

        assert(
            keccak256(abi.encodePacked(EnchantingCat)) ==
                keccak256(abi.encodePacked(tokenUri1))
        );

        assert(
            keccak256(abi.encodePacked(FanCat)) ==
                keccak256(abi.encodePacked(tokenUri2))
        );
    }
}
