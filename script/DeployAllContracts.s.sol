// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/ERC20Token.sol";
import "../src/ERC223Token.sol";
import "../src/ERC721Token.sol";

contract DeployAllContracts is Script {
    function run() external {
        vm.startBroadcast();

        // Déployer le contrat ERC20
        ERC20Token erc20 = new ERC20Token();
        console.log("ERC20 deployed to:", address(erc20));

        // Déployer le contrat ERC223
        ERC223 erc223 = new ERC223("MyERC223", "ERC223", 18, 1000000 * 10 ** 18);
        console.log("ERC223 deployed to:", address(erc223));

        // Déployer le contrat ERC721 (MyNFT) avec support ERC20 et ERC223
        MyNFT erc721 = new MyNFT(address(erc20), address(erc223), 100 * 10 ** 18, 100 * 10 ** 18); // Prix de mint: 100 ERC20 ou 100 ERC223
        console.log("ERC721 deployed to:", address(erc721));

        vm.stopBroadcast();
    }
}

//forge script script/DeployAllContracts.s.sol
//forge script script/DeployAllContracts.s.sol --broadcast --rpc-url https://eth-holesky.g.alchemy.com/v2/TSEmlkBqAolXiGkeRqEO96uZhPV12qWY