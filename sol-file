// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract SarahPresaleToken is ERC20, Ownable {
    uint256 public tokenPrice = 1000; // 1 HBAR = 1000 SARAH
    uint256 public tokensSold;
    bool public saleActive = true;

    constructor(uint256 initialSupply) 
    ERC20("SarahToken", "SARAH") 
    Ownable(msg.sender) 
{
    _mint(address(this), initialSupply * (10 ** decimals()));
}
function decimals() public view virtual override returns (uint8) {
    return 0;
}


    function buyTokens() public payable {
        require(saleActive, "Presale not active");
        require(msg.value > 0, "Send some HBAR");

        uint256 amountToBuy = msg.value * tokenPrice;
        require(balanceOf(address(this)) >= amountToBuy, "Not enough tokens left");

        tokensSold += amountToBuy;
        _transfer(address(this), msg.sender, amountToBuy);
    }

    function endSale() public onlyOwner {
        saleActive = false;
        payable(owner()).transfer(address(this).balance); // Withdraw collected HBAR to your wallet
    }
}
