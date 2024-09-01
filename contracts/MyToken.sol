// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract MyToken is Initializable, ERC20Upgradeable {
   /**
 * @dev Initializes the MyToken contract by setting the token name, symbol, and transferring ownership to the specified address.
 * This function replaces the constructor for upgradeable contracts.
 */

   function initialize(string memory name, string memory symbol) external initializer {
    __ERC20_init(name, symbol);
    _mint(msg.sender, 1000 * 1e18);


   }
}
