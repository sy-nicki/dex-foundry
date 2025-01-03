// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0 < 0.9.0;

interface IWETH {
    function deposit() external payable;  // 允许用户将以太币存入合约并将其转换为 WETH（Wrapped Ether）

    function withdraw(uint) external;      // 允许用户将 WETH 提取并转换为以太币

    function totalSupply() external view returns (uint);                // 获取 WETH 合约的总供应量

    function balanceOf(address account) external view returns (uint);   // 获取指定账户的 WETH 余额

    function transfer(address recipient, uint amount) external returns (bool);     // 转移 WETH 到指定的接收者地址

    function allowance(address spender, uint amount) external view returns (uint); // 查询指定地址（spender）可以从调用者账户提取的 WETH 数量

    function approve(address spender, uint amount) external returns (bool);                         // 授权指定地址（spender）能够提取指定数量的 WETH

    function transferFrom(address sender, address recipient, uint amount) external returns (bool);  // 从指定地址（sender）向接收地址（recipient）转移 WETH

    event Transfer(address indexed from, address indexed to, uint value);       // WETH 转账事件，记录从哪个地址（from）转账到哪个地址（to），转账的数量（value）

    event Approve(address indexed owner, address indexed spender, uint value);  // 授权事件，记录授权的地址（owner）给予某个地址（spender）授权的数量（value）
}
