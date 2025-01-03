// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 < 0.9.0;
pragma abicoder v2;

import {Test, console} from "forge-std/Test.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "../src/SwapToken.sol";
import "../src/interfaces/IWETH.sol";

contract SingleSwapTokenTest is Test {
    SwapToken public swapContract;

    address public user = address(0x1234);
    address public tokenDAI = address(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    address public tokenWETH = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    address public tokenUSDC = address(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    uint public amountIn = 1e18;
    uint public amountOut = 1000e6;

    IWETH dai;
    IWETH weth;
    IWETH usdc;

    function setUp() public {
        swapContract = new SwapToken();
        dai = IWETH(tokenDAI);
        weth = IWETH(tokenWETH);
        usdc = IWETH(tokenUSDC);

        vm.deal(user, 10 ether);

        assertEq(address(user).balance, 10 ether);

        assertTrue(address(weth) != address(0), "WETH address is invalid");

        vm.startPrank(user);
        weth.deposit{value: 1 ether}();
        weth.approve(address(swapContract), amountIn);
        vm.stopPrank();
    }

    function testSwapExactInputSingle() public {
        uint beforeBalance = usdc.balanceOf(user);

        uint amountOutReceived = swapContract.swapExactInputSingle(tokenWETH, tokenUSDC, amountIn);

        uint afterBalance = usdc.balanceOf(user);

        assertEq(afterBalance, beforeBalance + amountOutReceived);

    }

    function testSwapExactOutputSingle() public {
        uint beforeBalance = usdc.balanceOf(user);

        uint expectedAmountOut = 1000e6;
        uint amountInMaximum = 2e18;

        uint amountInUsed = swapContract.swapExactOutputSingle(tokenWETH, tokenUSDC, expectedAmountOut, amountInMaximum);

        uint afterBalance = usdc.balanceOf(user);

        assertEq(afterBalance, beforeBalance + expectedAmountOut);

        console.log("Amount of WETH used:", amountInUsed);
        assertTrue(amountInUsed <= amountInMaximum, "WETH input exceeds the maximum allowed amount");

        if (amountInUsed < amountInMaximum) {
            uint refundAmount = amountInMaximum - amountInUsed;
            TransferHelper.safeApprove(tokenWETH, address(swapContract), 0);
            TransferHelper.safeTransfer(tokenWETH, user, refundAmount);
        }
    }
}
