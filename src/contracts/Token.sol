// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {
  address public minter;

  event MinterChanged(address indexed from, address to);

  constructor() payable ERC20("RUN AWAY TOKEN", "RAT") {
    minter = msg.sender; //only initially
  }

  function passMinterRole(address genesis) public returns (bool) {
  	require(msg.sender==minter, 'Error, only owner can change pass minter role');
  	minter = genesis;

    emit MinterChanged(msg.sender, genesis);
    return true;
  }

  function mint(address account, uint256 amount) public {
		require(msg.sender==minter, 'Error, msg.sender does not have minter role'); //dBank
		_mint(account, amount);
	}
}