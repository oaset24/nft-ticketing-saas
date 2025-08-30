// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/interfaces/IERC2981.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract TicketCollection1155 is ERC1155, ERC1155Supply, AccessControl, Pausable, IERC2981, ReentrancyGuard {
    bytes32 public constant ORGANIZER_ROLE = keccak256("ORGANIZER_ROLE");
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant CHECKIN_ROLE = keccak256("CHECKIN_ROLE");

    mapping(uint256 => bool) public used;
    mapping(uint256 => uint256) public checkedIn;
    
    string public name;
    string public symbol;
    string private _contractURI;
    
    address private _royaltyReceiver;
    uint96 private _royaltyFeeBps;

    event Minted(address indexed to, uint256 indexed id, uint256 amount);
    event CheckedIn(uint256 indexed id, uint256 amount, address indexed scanner);
    event RoyaltySet(address indexed receiver, uint96 feeBps);

    constructor(
        string memory _name,
        string memory _symbol,
        string memory _uri,
        address _organizer,
        address _minter
    ) ERC1155(_uri) {
        name = _name;
        symbol = _symbol;
        _contractURI = _uri;
        
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ORGANIZER_ROLE, _organizer);
        _grantRole(MINTER_ROLE, _minter);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(CHECKIN_ROLE, _minter);
    }

    function mint(
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) external onlyRole(MINTER_ROLE) whenNotPaused nonReentrant {
        _mint(to, id, amount, data);
        emit Minted(to, id, amount);
    }

    function mintBatch(
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) external onlyRole(MINTER_ROLE) whenNotPaused nonReentrant {
        _mintBatch(to, ids, amounts, data);
        for (uint256 i = 0; i < ids.length; i++) {
            emit Minted(to, ids[i], amounts[i]);
        }
    }

    function checkIn(
        uint256 id,
        uint256 amount
    ) external onlyRole(CHECKIN_ROLE) whenNotPaused {
        require(exists(id), "Token does not exist");
        require(amount > 0, "Amount must be greater than 0");
        require(checkedIn[id] + amount <= totalSupply(id), "Cannot check in more than total supply");
        
        checkedIn[id] += amount;
        emit CheckedIn(id, amount, msg.sender);
    }

    function setURI(string memory newuri) external onlyRole(ORGANIZER_ROLE) {
        _setURI(newuri);
    }

    function setContractURI(string memory newContractURI) external onlyRole(ORGANIZER_ROLE) {
        _contractURI = newContractURI;
    }

    function contractURI() external view returns (string memory) {
        return _contractURI;
    }

    function setRoyaltyInfo(
        address receiver,
        uint96 feeBps
    ) external onlyRole(ORGANIZER_ROLE) {
        require(feeBps <= 10000, "Royalty fee too high");
        _royaltyReceiver = receiver;
        _royaltyFeeBps = feeBps;
        emit RoyaltySet(receiver, feeBps);
    }

    function royaltyInfo(
        uint256,
        uint256 salePrice
    ) external view override returns (address, uint256) {
        uint256 royaltyAmount = (salePrice * _royaltyFeeBps) / 10000;
        return (_royaltyReceiver, royaltyAmount);
    }

    function pause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function unpause() external onlyRole(PAUSER_ROLE) {
        _unpause();
    }

    function isCheckedIn(uint256 id) external view returns (bool) {
        return checkedIn[id] > 0;
    }

    function getCheckedInAmount(uint256 id) external view returns (uint256) {
        return checkedIn[id];
    }

    function getRemainingTickets(uint256 id) external view returns (uint256) {
        return totalSupply(id) - checkedIn[id];
    }

    function _update(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory values
    ) internal override(ERC1155, ERC1155Supply) whenNotPaused {
        super._update(from, to, ids, values);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC1155, AccessControl, IERC165) returns (bool) {
        return
            interfaceId == type(IERC2981).interfaceId ||
            super.supportsInterface(interfaceId);
    }
}
