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
    
}




