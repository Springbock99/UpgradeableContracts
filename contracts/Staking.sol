// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./MyNFT.sol";

error AlreadyStaked(address account, string reason);

/**
 * @title StakingContract
 * @dev A staking contract allowing users to stake and unstake NFTs to earn rewards.
 */
contract StakingContract is Initializable, IERC721Receiver, ERC20Upgradeable {
    IERC20 public token;
    IERC721 public itemNFT;
    uint256 public constant rewardRate = 10;

    mapping(uint256 => address) public originalOwner;
    mapping(address => StakedeNFTs[]) public stakedNFT;
    mapping(address => bool) public ifStaked;
    mapping(address => uint256) public lastRewardTime;

    struct StakedeNFTs {
        uint256 tokenId;
        uint256 startTime;
    }

    /**
     * @dev Modifier to ensure that the staker is not already staked.
     */
    modifier alreadyStaked() {
        if (ifStaked[msg.sender])
            revert AlreadyStaked(msg.sender, "token already staked");
        _;
    }
/**
 * @dev Initializes the StakingContract by setting the ERC20 token and NFT contract addresses.
 * This function replaces the constructor for upgradeable contracts.
 * @param erc20 The address of the ERC20 token contract used for rewards.
 * @param NFT The address of the ERC721 token contract for staking.
 */

    function initialize (IERC20 erc20, IERC721 NFT) external initializer {
        token = erc20;
        itemNFT = NFT;
    }

    /**
     * @dev ERC721 receiver function to handle NFT deposits.
     */
    function onERC721Received(
        address, // operator,
        address, // from,
        uint256, // tokenId,
        bytes calldata // data
    ) external pure returns (bytes4) {
        return IERC721Receiver.onERC721Received.selector;
    }

    /**
     * @dev Deposit an NFT into the staking contract.
     * @param tokenId The ID of the NFT to be deposited.
     */
    function depositNFT(uint256 tokenId) external {
        originalOwner[tokenId] = msg.sender;
        itemNFT.safeTransferFrom(msg.sender, address(this), tokenId);
    }

    /**
     * @dev Stake an NFT to start earning rewards.
     * @param tokenId The ID of the NFT to be staked.
     */
    function stake(uint256 tokenId) external alreadyStaked {
        originalOwner[tokenId] == msg.sender;
        stakedNFT[msg.sender].push(StakedeNFTs(tokenId, block.timestamp));
    }

    /**
     * @dev Unstake an NFT and claim rewards.
     * @param tokenId The ID of the NFT to be unstaked.
     */
    function unstakeAndClaimRewards(uint256 tokenId) external alreadyStaked {
        require(stakedNFT[msg.sender].length > 0, "No NFTs staked");
        uint256 indexToRemove;

        for (uint256 i = 0; i < stakedNFT[msg.sender].length; i++) {
            if (stakedNFT[msg.sender][i].tokenId == tokenId) {
                indexToRemove = i;
                break;
            }
        }

        require(
            indexToRemove < stakedNFT[msg.sender].length,
            "NFT not found in staked list"
        );

        _getRewards(msg.sender);

        itemNFT.safeTransferFrom(address(this), msg.sender, tokenId);

        for (
            uint256 i = indexToRemove;
            i < stakedNFT[msg.sender].length - 1;
            i++
        ) {
            stakedNFT[msg.sender][i] = stakedNFT[msg.sender][i + 1];
        }
        stakedNFT[msg.sender].pop();

        ifStaked[msg.sender] = false;
    }

    /**
     * @dev Internal function to calculate and transfer rewards to the user.
     * @param user The address of the user to receive the rewards.
     */
    function _getRewards(address user) internal {
        uint256 currentTime = block.timestamp;
        uint256 elapsedTime = currentTime - lastRewardTime[user];

        if (elapsedTime > 0) {
            uint256 earnedRewards = (elapsedTime * rewardRate) / (24 hours);
            lastRewardTime[user] = currentTime;

            token.transfer(user, earnedRewards);
        }
    }

    /**
     * @dev Claim rewards for a specific NFT.
     * @param tokenId The ID of the NFT for which rewards are to be claimed.
     */
    function getRewards(uint256 tokenId) external {
        require(originalOwner[tokenId] == msg.sender);
        _getRewards(msg.sender);
    }
}
