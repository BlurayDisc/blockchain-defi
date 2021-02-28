// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;

import "./Token.sol";

contract Bank {

    Token private token;

    mapping(address => uint) public etherBalanceOf;
    mapping(address => uint) public depositStart;
    mapping(address => bool) public isDeposited;

    event Deposit(address indexed user, uint etherAmount, uint depositTime);
    event Withdraw(address indexed user, uint etherAmount, uint hodlTime, uint interest);

    constructor(Token tokenAddress) {
        token = tokenAddress;
    }

    function deposit() payable public {
        require(!isDeposited[msg.sender], 'Already deposited');
        require(msg.value >= 1e16, 'must be >= 0.01 eth');

        etherBalanceOf[msg.sender] = etherBalanceOf[msg.sender]  + msg.value;
        depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;
        isDeposited[msg.sender] = true;

        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw() payable public {
        require(isDeposited[msg.sender], 'no previous deposit');

        uint userBalance = etherBalanceOf[msg.sender];

        // calc interest per second then accured interest
        uint hodlTime = block.timestamp - depositStart[msg.sender];

        // 1e15 gwei (10% of 0.01 ETH) / 31577600 (seconds in 365.25 days)
        uint interestPerSecond = 31668017 * (userBalance / 1e16);
        uint interest = interestPerSecond * hodlTime;

        msg.sender.transfer(userBalance);
        token.mint(msg.sender, interest);

        depositStart[msg.sender] = 0;
        etherBalanceOf[msg.sender] = 0;
        isDeposited[msg.sender] = false;
        emit Withdraw(msg.sender, userBalance, hodlTime, interest);
    }

    function borrow() payable public {
        // require(msg.value>=1e16, 'Error, collateral must be >= 0.01 ETH');
        // require(isBorrowed[msg.sender] == false, 'Error, loan already taken');

        // //this Ether will be locked till user payOff the loan
        // collateralEther[msg.sender] = collateralEther[msg.sender] + msg.value;

        // //calc tokens amount to mint, 50% of msg.value
        // uint tokensToMint = collateralEther[msg.sender] / 2;

        // //mint&send tokens to user
        // token.mint(msg.sender, tokensToMint);

        // //activate borrower's loan status
        // isBorrowed[msg.sender] = true;

        // emit Borrow(msg.sender, collateralEther[msg.sender], tokensToMint);
    }

    function payOff() public {
        // require(isBorrowed[msg.sender] == true, 'Error, loan not active');
        // require(token.transferFrom(msg.sender, address(this), collateralEther[msg.sender]/2), "Error, can't receive tokens"); //must approve dBank 1st

        // uint fee = collateralEther[msg.sender]/10; //calc 10% fee

        // //send user's collateral minus fee
        // msg.sender.transfer(collateralEther[msg.sender]-fee);

        // //reset borrower's data
        // collateralEther[msg.sender] = 0;
        // isBorrowed[msg.sender] = false;

        // emit PayOff(msg.sender, fee);
    }
}