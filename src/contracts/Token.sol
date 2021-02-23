// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;
  address public rat;

  event MinterChanged(address indexed from, address to);

  constructor() payable ERC20("Run Away Token", "RAT") {
    minter = rat = msg.sender; //only initially
  }

  function passMinterRole(address bankAddress) public returns (bool) {
  	require(msg.sender==minter, 'Error, only owner can change pass minter role');
  	minter = bankAddress;

    emit MinterChanged(msg.sender, bankAddress);
    return true;
  }

  function mint(address account, uint256 amount) public {
		require(msg.sender==minter || msg.sender==rat, 'Error, msg.sender does not have minter role'); //dBank
		_mint(account, amount);
	}
}