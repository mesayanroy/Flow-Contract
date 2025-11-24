# 🕹️ FlowArcadeNFT..

A gamified ERC-721 (NFT) smart contract built with Solidity and OpenZeppelin, designed to represent player achievements in a blockchain-based game. Each NFT tracks a player’s experience points (XP) and level, automatically updating as they progress through the game.

<img width="1082" height="633" alt="Screenshot 2025-10-18 124132" src="https://github.com/user-attachments/assets/41119760-56ab-40e8-bbea-3785521943d6" />


⚙️ Features

ERC-721 Standard — Fully compliant NFT implementation.

XP & Level System — NFTs accumulate XP and level up dynamically based on thresholds.

Game Authority Role — Only the authorized game contract or admin can award XP.

Custom Base URI — Owner can configure metadata base URI for NFTs.

Upgradeable Level Thresholds — Easily manage XP milestones per level.

🧩 Contract Overview

Contract Address - 0xb96F31bc07777f1f48De16533225f0964951E8f1

State Variables
Variable	Type	Description
_tokenIdCounter	uint256	Keeps track of minted token IDs
xp	mapping(uint256 => uint256)	Stores XP earned per NFT
baseURI	string	Base URI for metadata
gameAuthority	address	Address allowed to award XP
levelThresholds	uint256[]	XP thresholds defining player levels
🔑 Access Control

onlyOwner → Used for administrative functions (e.g., setting URI or authority).

onlyGameAuthority → Restricts XP awarding to trusted in-game systems.

🧠 Core Functions
Function	Description
mint()	Mints a new NFT for the caller and returns the new token ID.
awardXP(uint256 tokenId, uint256 amount)	Awards XP to a given token; emits events and triggers level up if applicable.
getLevel(uint256 tokenId)	Calculates and returns the NFT’s level based on XP thresholds.
setBaseURI(string calldata uri)	Updates the base URI for metadata.
setGameAuthority(address auth)	Assigns a new game authority.
tokenURI(uint256 tokenId)	Returns metadata URL for the given token ID.
📡 Events
Event	Description
XPAwarded(uint256 tokenId, uint256 newXP)	Emitted when XP is awarded.
LevelUp(uint256 tokenId, uint256 newLevel)	Emitted when an NFT reaches a new level.
🚀 Deployment
1️⃣ Install Dependencies
npm install @openzeppelin/contracts

2️⃣ Compile
npx hardhat compile

3️⃣ Deploy (Example)
const FlowArcadeNFT = await ethers.getContractFactory("FlowArcadeNFT");
const flowArcade = await FlowArcadeNFT.deploy("FlowArcade NFT", "FANFT");
await flowArcade.deployed();
console.log("Deployed at:", flowArcade.address);

🧮 Example Usage
// Mint an NFT
await flowArcade.connect(player).mint();

// Award XP (gameAuthority only)
await flowArcade.connect(gameAuthority).awardXP(1, 150);

// Get player level
const level = await flowArcade.getLevel(1);
console.log("Player Level:", level.toString());

🧱 Level System Example
Level	XP Threshold
0	0
1	100
2	300
3	700
4	1500
5	3000
🔐 License

This project is licensed under the MIT License.
See the LICENSE
 file for details.
