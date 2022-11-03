// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@thirdweb-dev/contracts/base/ERC721Base.sol";
import "@thirdweb-dev/contracts/extension/PermissionsEnumerable.sol";

contract Contract is ERC721Base, PermissionsEnumerable {

    mapping (uint256 => uint256) public powerLevel;

      constructor(
        string memory _name,
        string memory _symbol,
        address _royaltyRecipient,
        uint128 _royaltyBps
    )
        ERC721Base(
            _name,
            _symbol,
            _royaltyRecipient,
            _royaltyBps
        )
    {
        // Give the contract deployer the "admin" role when the contract is deployed.
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }

    function setPowerLevel(uint256 _tokenId, uint256 _powerLevel) external onlyRole(DEFAULT_ADMIN_ROLE) {
        powerLevel[_tokenId] = _powerLevel;
    }

    function mintTo(address _to, string memory _tokenURI) public virtual override {
        // Grab next token id
        uint256 tokenId = nextTokenIdToMint();

        // Run the mintTo method from the base contract
        super.mintTo(_to, _tokenURI);

        // Add our custom logic on top:
        powerLevel[tokenId] = tokenId;
    }

}