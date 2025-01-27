// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract TestMoodNft is Test {
    MoodNft moodNft;
    string public constant SAD_SVG_URI =
        "data:image/svg+xml;base64,Cgo8c3ZnIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iNDAwIiBoZWlnaHQ9IjQwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIGZpbGw9ImJsYWNrIiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8+CiAgPGcgY2xhc3M9ImV5ZXMiIGZpbGw9IndoaXRlIj4KICAgIDxjaXJjbGUgY3g9IjcwIiBjeT0iODIiIHI9IjEyIi8+CiAgICA8Y2lyY2xlIGN4PSIxMjciIGN5PSI4MiIgcj0iMTIiLz4KICA8L2c+CiAgPHBhdGggZD0iTTYzLjY5IDEzMy4yOGMuNjktMjYuMTcgNjQuMTEtNDIgODEuNTIuNzMiIHN0eWxlPSJmaWxsOm5vbmU7IHN0cm9rZTogd2hpdGU7IHN0cm9rZS13aWR0aDogMzsiLz4KPC9zdmc+";

    string public constant HAPPY_SVG_URI =
        "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0iYmxhY2siIHI9Ijc4IiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9IjMiLz4KICA8ZyBjbGFzcz0iZXllcyIgZmlsbD0id2hpdGUiPgogICAgPGNpcmNsZSBjeD0iNzAiIGN5PSI4MiIgcj0iMTIiLz4KICAgIDxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPgogIDwvZz4KICA8cGF0aCBkPSJtMTM2LjgxIDExNi41M2MuNjkgMjYuMTctNjQuMTEgNDItODEuNTItLjczIiBzdHlsZT0iZmlsbDpub25lOyBzdHJva2U6IHdoaXRlOyBzdHJva2Utd2lkdGg6IDM7Ii8+Cjwvc3ZnPgo=";

    address USER = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNft(SAD_SVG_URI, HAPPY_SVG_URI);
    }

    function testViewTokenURI() public {
        vm.startPrank(USER);
        moodNft.mintNft();
        vm.stopPrank();
        console2.log(moodNft.tokenURI(0));
    }
}
