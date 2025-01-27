// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {MoodNft} from "../../src/MoodNft.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";

contract TestMoodNftIntegration is Test {
    MoodNft moodNft;
    DeployMoodNft public deployer;

    string public constant SAD_SVG_Image_URI =
        "data:image/svg+xml;base64,Cgo8c3ZnIHZpZXdCb3g9IjAgMCAyMDAgMjAwIiB3aWR0aD0iNDAwIiBoZWlnaHQ9IjQwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8Y2lyY2xlIGN4PSIxMDAiIGN5PSIxMDAiIGZpbGw9ImJsYWNrIiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8+CiAgPGcgY2xhc3M9ImV5ZXMiIGZpbGw9IndoaXRlIj4KICAgIDxjaXJjbGUgY3g9IjcwIiBjeT0iODIiIHI9IjEyIi8+CiAgICA8Y2lyY2xlIGN4PSIxMjciIGN5PSI4MiIgcj0iMTIiLz4KICA8L2c+CiAgPHBhdGggZD0iTTYzLjY5IDEzMy4yOGMuNjktMjYuMTcgNjQuMTEtNDIgODEuNTIuNzMiIHN0eWxlPSJmaWxsOm5vbmU7IHN0cm9rZTogd2hpdGU7IHN0cm9rZS13aWR0aDogMzsiLz4KPC9zdmc+";

    string public constant HAPPY_SVG_Image_URI =
        "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0iYmxhY2siIHI9Ijc4IiBzdHJva2U9ImJsYWNrIiBzdHJva2Utd2lkdGg9IjMiLz4KICA8ZyBjbGFzcz0iZXllcyIgZmlsbD0id2hpdGUiPgogICAgPGNpcmNsZSBjeD0iNzAiIGN5PSI4MiIgcj0iMTIiLz4KICAgIDxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPgogIDwvZz4KICA8cGF0aCBkPSJtMTM2LjgxIDExNi41M2MuNjkgMjYuMTctNjQuMTEgNDItODEuNTItLjczIiBzdHlsZT0iZmlsbDpub25lOyBzdHJva2U6IHdoaXRlOyBzdHJva2Utd2lkdGg6IDM7Ii8+Cjwvc3ZnPgo=";

    string public constant HAPPY_SVG_URI =
        "data:application/json;base64,eyJuYW1lIjogIk1vb2ROZnQiLCAiZGVzY3JpcHRpb24iOiAiQW4gTkZUIHRoYXQgcmVmbGVjdHMgb3duZXJzIG1vb2QuIiwgImF0dHJpYnV0ZXMiOlt7InRyYWl0X3R5cGUiOiAibW9vZF9TY29yZSIsICJ2YWx1ZSI6ICIxMDAifV0sICJpbWFnZSI6ImRhdGE6aW1hZ2Uvc3ZnK3htbDtiYXNlNjQsUEhOMlp5QjJhV1YzUW05NFBTSXdJREFnTWpBd0lESXdNQ0lnZDJsa2RHZzlJalF3TUNJZ0lHaGxhV2RvZEQwaU5EQXdJaUI0Yld4dWN6MGlhSFIwY0RvdkwzZDNkeTUzTXk1dmNtY3ZNakF3TUM5emRtY2lQZ29nSUR4amFYSmpiR1VnWTNnOUlqRXdNQ0lnWTNrOUlqRXdNQ0lnWm1sc2JEMGlZbXhoWTJzaUlISTlJamM0SWlCemRISnZhMlU5SW1Kc1lXTnJJaUJ6ZEhKdmEyVXRkMmxrZEdnOUlqTWlMejRLSUNBOFp5QmpiR0Z6Y3owaVpYbGxjeUlnWm1sc2JEMGlkMmhwZEdVaVBnb2dJQ0FnUEdOcGNtTnNaU0JqZUQwaU56QWlJR041UFNJNE1pSWdjajBpTVRJaUx6NEtJQ0FnSUR4amFYSmpiR1VnWTNnOUlqRXlOeUlnWTNrOUlqZ3lJaUJ5UFNJeE1pSXZQZ29nSUR3dlp6NEtJQ0E4Y0dGMGFDQmtQU0p0TVRNMkxqZ3hJREV4Tmk0MU0yTXVOamtnTWpZdU1UY3ROalF1TVRFZ05ESXRPREV1TlRJdExqY3pJaUJ6ZEhsc1pUMGlabWxzYkRwdWIyNWxPeUJ6ZEhKdmEyVTZJSGRvYVhSbE95QnpkSEp2YTJVdGQybGtkR2c2SURNN0lpOCtDand2YzNablBnbz0ifQ==";

    address USER = makeAddr("user");

    function setUp() public {
        deployer = new DeployMoodNft();
        moodNft = deployer.run();
    }

    function testViewTokenURIIntegration() public {
        vm.startPrank(USER);
        moodNft.mintNft();
        vm.stopPrank();
        console2.log(moodNft.tokenURI(0));
    }

    function testFlipTokenToHappy() public {
        vm.prank(USER);
        moodNft.mintNft();

        vm.prank(USER);
        moodNft.flipMood(0);

        console2.log(moodNft.tokenURI(0));

        assertEq(
            keccak256(abi.encodePacked(moodNft.tokenURI(0))),
            keccak256(abi.encodePacked(HAPPY_SVG_URI))
        );
    }
}
