# Upgradeable NFT Staking Platform

A comprehensive blockchain-based platform featuring upgradeable smart contracts that allow users to mint NFTs, stake them, and earn ERC20 token rewards.

## Tech Stack

- **Solidity**: Core smart contract development
- **OpenZeppelin Upgradeable Contracts**: Framework for creating proxy-based upgradeable contracts
- **JavaScript**: Deployment and interaction scripts
- **IPFS**: Decentralized storage for NFT metadata
- **ERC721**: Standard for non-fungible tokens
- **ERC20**: Standard for fungible token rewards

## Features

- **Upgradeable Contracts**: All contracts utilize the proxy pattern for future upgrades without losing state
- **NFT Staking**: Users can stake their NFTs to earn token rewards over time
- **Reward System**: Configurable reward rate for staked NFTs
- **Force Transfer**: Admin capability to force transfer NFTs when necessary
- **Blacklist Management**: Token contract includes blacklisting functionality for security
- **Balance Manipulation**: Admin functions to adjust token balances for specific addresses

## Smart Contract Architecture

### MyNFT.sol

- Upgradeable ERC721 implementation
- Minting functionality
- IPFS-based metadata
- Force transfer capability for admins

### MyToken.sol

- Upgradeable ERC20 implementation
- Basic token functionality for rewards

### StakingContract.sol

- Handles NFT deposits and withdrawals
- Calculates and distributes rewards
- Tracks staked NFTs and their original owners

### GodeMode.sol

- Extended ERC20 implementation
- Blacklist management
- Balance manipulation capabilities
- Capped supply

## Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) and npm
- [Hardhat](https://hardhat.org/) for development and testing
- [OpenZeppelin SDK](https://docs.openzeppelin.com/sdk/2.5/)

### Installation

1. Clone the repository
   ```bash
   git clone https://github.com/yourusername/upgradeable-nft-staking.git
   cd upgradeable-nft-staking
   ```
