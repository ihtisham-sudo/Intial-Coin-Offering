// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface ICryptoDevs {
    function tokenofOwnerByIndex (address owner, uint256 Index) external view returns (uint256 tokenId);
    function balanceof (address owner) external view returns (uint256 balance);
    
    
}