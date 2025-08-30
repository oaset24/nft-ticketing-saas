// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "./TicketCollection1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CollectionFactory is Ownable {
    event CollectionCreated(
        address indexed collection,
        address indexed organizer,
        string name,
        string symbol
    );

    mapping(address => address[]) public organizerCollections;
    address[] public allCollections;

    constructor() Ownable(msg.sender) {}

    function createCollection(
        string memory name,
        string memory symbol,
        string memory uri,
        address organizer,
        address minter
    ) external returns (address) {
        TicketCollection1155 collection = new TicketCollection1155(
            name,
            symbol,
            uri,
            organizer,
            minter
        );

        address collectionAddress = address(collection);
        
        organizerCollections[organizer].push(collectionAddress);
        allCollections.push(collectionAddress);

        emit CollectionCreated(collectionAddress, organizer, name, symbol);
        
        return collectionAddress;
    }

    function getOrganizerCollections(
        address organizer
    ) external view returns (address[] memory) {
        return organizerCollections[organizer];
    }

    function getAllCollections() external view returns (address[] memory) {
        return allCollections;
    }

    function getCollectionCount() external view returns (uint256) {
        return allCollections.length;
    }
}
