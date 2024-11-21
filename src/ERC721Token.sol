// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "../src/ERC20Token.sol";
import "../src/ERC223Token.sol";
import "forge-std/console.sol";

contract MyNFT is ERC721 {
    uint256 public tokenCounter;
    ERC20Token public erc20Token;
    ERC223 public erc223Token;
    uint256 public mintPriceERC20;
    uint256 public mintPriceERC223;

    constructor(
        address _erc20TokenAddress,
        address _erc223TokenAddress,
        uint256 _mintPriceERC20,
        uint256 _mintPriceERC223
    ) ERC721("MyNFT", "NFT") {
        tokenCounter = 0;
        erc20Token = ERC20Token(_erc20TokenAddress);
        erc223Token = ERC223(_erc223TokenAddress);
        mintPriceERC20 = _mintPriceERC20;
        mintPriceERC223 = _mintPriceERC223;
    }

    function tokenFallback(address _from, uint256 _value, bytes memory) public {
        console.log("tokenFallback called, from:", _from, ", value:", _value);

        require(msg.sender == address(erc223Token), "Only the accepted ERC223 token can trigger minting");
        require(_value >= mintPriceERC223, "Insufficient ERC223 tokens to mint a NFT");

        uint256 newItemId = tokenCounter;

        console.log("Attempting to mint NFT with ID:", newItemId, "for:", _from);

        _mint(_from, newItemId);
        tokenCounter += 1;

        console.log("Minted NFT with ID:", newItemId, "to:", _from);
    }
}
