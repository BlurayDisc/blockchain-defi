# blockchain-defi
 Blockchain defi for the Run Away Token (RAT)

# Commands

## Token Commands
const token = await Token.deloyed()
token.name()
token.symbol()
token.totalSupply()

## Account Commands
const accounts = await web3.eth.getAccounts()
account = accounts[0]

## Balance Commands
const balance = await web3.eth.getBalance(account)
web3.utils.fromWei(balance)
web3.utils.toWei('98.89')

const decimal = await token.decimals()
decimal.toString()

const tokenBalance = await token.balanceOf(account)
tokenBalance.toNumber()

## Mint
token.mint(account, web3.utils.toWei('100'))