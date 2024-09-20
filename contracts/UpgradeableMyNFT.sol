pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

error notOwner();


contract MyNFT is Initializable, ERC721Upgradeable, OwnableUpgradeable {
  uint256 private _tokenIdCounter;
  using Strings for uint256;

  event ForcedTransfer(address indexed from, address indexed to, uint256 indexed tokenId);



    function initialize () external initializer{
        __ERC721_init("MyNFT", " MNFT");
        __Ownable_init(msg.sender);
    }

  
  function mint(address to) external {
    _safeMint(to, _tokenIdCounter);
    _tokenIdCounter++;
  }

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

   function _baseURI() internal pure override returns (string memory) {
        return "ipfs://QmYPdi5nLPCrEugAZoxaqhK1RyEyoz3w4pb6tLuKqf5Sd7/";
    }

    
    function forceTransfer(address from, address to,uint256 tokenId) external onlyOwner {

      safeTransferFrom(from, to,tokenId, "");
      emit ForcedTransfer(from, to, tokenId);
    }

}