// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract SarahPresaleTokenV2 is ERC20, Ownable {
    uint256 public tokenPrice = 1000; // 1 HBAR = 1000 tokens
    uint256 public tokensSold;
    bool public saleActive = true;

    constructor(uint256 initialSupply) ERC20("SarahToken", "SARAH") Ownable(msg.sender) {
        _mint(address(this), initialSupply * (10 ** decimals()));
    }

    function decimals() public view virtual override returns (uint8) {
        return 0;
    }

    function buyTokens() public payable {
        require(saleActive, "Sale is not active");
        require(msg.value > 0, "Send HBAR to buy tokens");

        uint256 amountToBuy = msg.value * tokenPrice;
        require(balanceOf(address(this)) >= amountToBuy, "Not enough tokens left");

        tokensSold += amountToBuy;
        _transfer(address(this), msg.sender, amountToBuy);

        emit TokensPurchased(msg.sender, amountToBuy, msg.value);
    }

    function pauseSale() public onlyOwner {
        saleActive = false;
    }

    function resumeSale() public onlyOwner {
        saleActive = true;
    }

    function withdrawFunds() public onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }

    event TokensPurchased(address indexed buyer, uint256 amount, uint256 cost);
}
