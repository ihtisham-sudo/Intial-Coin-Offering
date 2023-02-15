//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ICryptoDevs.sol";

contract CryptoDevToken is ERC20, Ownable {
    uint public constant tokenPrice = 0.001 ether;
    uint public constant tokenperNFT = 10 * 10 ** 18;
    uint public constant maxSupply = 1000 * 10 ** 18;
    ICryptoDevs CryptoDevsNFT;
    mapping (uint256 => bool) tokenIdsClaimed;
    constructor (address _cryptodevscontract) ERC20("CryptoDevToken", "CD")
    {
        CryptoDevsNFT = ICryptoDevs(_cryptodevscontract);
    }
    function mint (uint256 amount) public payable {
        uint256 _requiredamount = tokenPrice * amount;
        require (msg.value >= _requiredamount, "Ether sent is incorrect");
        uint256 amountwithDecimals = amount * 10 ** 18;
        require(totalSupply() + amountwithDecimals <= maxSupply, "Exceed the amount of max supply");
        _mint(msg.sender, amountwithDecimals);
    }

    function claim() public 
    {
        address sender  = msg.sender;
        uint256 balance = CryptoDevsNFT.balanceof(sender);
        require (balance > 0, "You don't own any crypto NFT");
        uint256 amount = 0;
        for (uint256 i = 0; i < balance ; i++)
        {
            uint256 tokenId = CryptoDevsNFT.tokenofOwnerByIndex(sender, i);
            if (!tokenIdsClaimed[tokenId])
            {
                amount += 1;
                tokenIdsClaimed[tokenId] = true;
            }
        }
        require (amount > 0, "You have already claimed all the tokens");
        _mint(msg.sender, amount * tokenperNFT);
    }
    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;
        require(amount > 0, "Nothing to withdraw, contract balance empty");
        address _owner = owner();
        (bool sent, ) = _owner.call{value: amount}("");
        


    }
}




