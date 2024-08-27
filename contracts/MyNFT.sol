// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";


/**
 * @title MyNFT, my own NFT
 * @dev A simple ERC721 token contract for creating and managing unique NFTs.
 */
contract MyNFT is Initializable,  ERC721Upgradeable, OwnableUpgradeable {
    uint256 private _tokenIdCounter;
    using Strings for uint256;

/**
 * @dev Initializes the MyNFT contract by setting the token name, symbol, and transferring ownership to the specified address.
 * This function replaces the constructor for upgradeable contracts.
 */


    function initialize () external initializer{
        __ERC721_init("MyNFT", " MNFT");
        __Ownable_init(msg.sender);
    }
    /**
     * @dev Mint a new NFT to the specified address.
     * @param to The address to mint the NFT to.
     */
    function mint(address to) external {
        _safeMint(to, _tokenIdCounter);
        _tokenIdCounter++;
    }

    /**
     * @dev Get the token URI for a given tokenId.
     * @param tokenId The ID of the token to get the URI for.
     * @return The token URI.
     */
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        _requireOwned(tokenId);
        string memory baseURI = _baseURI();
        return
            bytes(baseURI).length > 0
                ? string.concat(baseURI, tokenId.toString())
                : "";
    }

    /**
     * @dev Internal function to specify the base URI for token metadata.
     * @return The base URI for token metadata.
     */
    function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmYPdi5nLPCrEugAZoxaqhK1RyEyoz3w4pb6tLuKqf5Sd7/";
    }

    /**
     * @dev Internal function to ensure that the tokenId is owned by the contract.
     * @param tokenId The ID of the token to check ownership for.
     */
    function requireOwned(uint256 tokenId) internal view {
        require(ownerOf(tokenId) == address(this), "Token not owned by contract");
    }
}
