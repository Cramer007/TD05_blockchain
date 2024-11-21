// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/ERC223Token.sol";
import "../src/ERC721Token.sol";

contract ERC721Test is Test {
    MyNFT nft;
    ERC223 erc223;

    function setUp() public {
    console.log("Setting up ERC223...");
    erc223 = new ERC223("MyERC223", "ERC223", 18, 1000000 * 10 ** 18);
    console.log("ERC223 deployed");

    uint256 mintPriceERC223 = 100 * 10 ** 18;
    console.log("Mint price ERC223 set:", mintPriceERC223);

    nft = new MyNFT(address(erc223), address(erc223), mintPriceERC223, mintPriceERC223);
    console.log("NFT contract deployed");

    // Assurez-vous que l'adresse de test est bien autorisée à recevoir les tokens
    uint256 balance = erc223.balanceOf(address(this));
    console.log("Test contract ERC223 balance:", balance);

    if (balance >= 1000 * 10 ** 18) {
        erc223.transfer(address(this), 1000 * 10 ** 18, "");
        console.log("ERC223 tokens transferred to test contract");
    } else {
        console.log("Insufficient balance for ERC223 transfer");
    }
}


    function testMintNFTWithERC223() public {
        // Assure-toi que le solde est suffisant
        assertEq(erc223.balanceOf(address(this)), 1000 * 10 ** 18);

        // Transférer les tokens ERC223 pour déclencher le mint
        erc223.transfer(address(nft), 100 * 10 ** 18, ""); // Transfert pour mint

        // Vérifier que le NFT a bien été minté
        address nftOwner = nft.ownerOf(0);
        console.log("Owner of NFT with ID 0 is:", nftOwner);
        assertEq(nftOwner, address(this));
    }
}
