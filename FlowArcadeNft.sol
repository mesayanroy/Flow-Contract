// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract FlowArcadeNFT is ERC721, Ownable {
    uint256 private _tokenIdCounter;
    mapping(uint256 => uint256) public xp;
    string public baseURI;
    address public gameAuthority;
    uint256[] public levelThresholds = [0, 100, 300, 700, 1500, 3000];

    event XPAwarded(uint256 indexed tokenId, uint256 newXP);
    event LevelUp(uint256 indexed tokenId, uint256 newLevel);

    constructor(string memory name_, string memory symbol_) 
        ERC721(name_, symbol_) Ownable(msg.sender) {}

    modifier onlyGameAuthority() {
        require(msg.sender == gameAuthority, "Not authorized");
        _;
    }

    function setBaseURI(string calldata uri) external onlyOwner {
        baseURI = uri;
    }

    function setGameAuthority(address auth) external onlyOwner {
        gameAuthority = auth;
    }

    function mint() external returns (uint256) {
        uint256 id = ++_tokenIdCounter;
        _safeMint(msg.sender, id);
        return id;
    }

    function awardXP(uint256 tokenId, uint256 amount) external onlyGameAuthority {
        require(_ownerOf(tokenId) != address(0), "Invalid token");
        uint256 oldLevel = getLevel(tokenId);
        xp[tokenId] += amount;
        emit XPAwarded(tokenId, xp[tokenId]);
        
        uint256 newLevel = getLevel(tokenId);
        if (newLevel > oldLevel) emit LevelUp(tokenId, newLevel);
    }

    function getLevel(uint256 tokenId) public view returns (uint256) {
        uint256 _xp = xp[tokenId];
        for (uint i = levelThresholds.length; i > 0; i--) {
            if (_xp >= levelThresholds[i - 1]) return i - 1;
        }
        return 0;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_ownerOf(tokenId) != address(0), "Invalid token");
        return bytes(baseURI).length > 0 
            ? string(abi.encodePacked(baseURI, _toString(tokenId)))
            : "";
    }

    function _toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) return "0";
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}
