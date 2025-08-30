// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/TicketCollection1155.sol";
import "../src/CollectionFactory.sol";

contract TicketCollection1155Test is Test {
    TicketCollection1155 public ticketCollection;
    CollectionFactory public factory;
    
    address public organizer = address(0x1);
    address public minter = address(0x2);
    address public buyer = address(0x3);
    address public scanner = address(0x4);
    
    function setUp() public {
        factory = new CollectionFactory();
        
        vm.prank(organizer);
        address collectionAddress = factory.createCollection(
            "Test Event",
            "TEST",
            "https://example.com/metadata/",
            organizer,
            minter
        );
        
        ticketCollection = TicketCollection1155(collectionAddress);
    }
    
    function testMint() public {
        uint256 tokenId = 1;
        uint256 amount = 100;
        
        vm.prank(minter);
        ticketCollection.mint(buyer, tokenId, amount, "");
        
        assertEq(ticketCollection.balanceOf(buyer, tokenId), amount);
        assertEq(ticketCollection.totalSupply(tokenId), amount);
    }
    
    function testMintBatch() public {
        uint256[] memory tokenIds = new uint256[](2);
        tokenIds[0] = 1;
        tokenIds[1] = 2;
        
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 100;
        amounts[1] = 50;
        
        vm.prank(minter);
        ticketCollection.mintBatch(buyer, tokenIds, amounts, "");
        
        assertEq(ticketCollection.balanceOf(buyer, tokenIds[0]), amounts[0]);
        assertEq(ticketCollection.balanceOf(buyer, tokenIds[1]), amounts[1]);
        assertEq(ticketCollection.totalSupply(tokenIds[0]), amounts[0]);
        assertEq(ticketCollection.totalSupply(tokenIds[1]), amounts[1]);
    }
    
    function testCheckIn() public {
        uint256 tokenId = 1;
        uint256 mintAmount = 100;
        uint256 checkInAmount = 1;
        
        vm.prank(minter);
        ticketCollection.mint(buyer, tokenId, mintAmount, "");
        
        vm.prank(minter);
        ticketCollection.checkIn(tokenId, checkInAmount);
        
        assertEq(ticketCollection.getCheckedInAmount(tokenId), checkInAmount);
        assertEq(ticketCollection.getRemainingTickets(tokenId), mintAmount - checkInAmount);
        assertTrue(ticketCollection.isCheckedIn(tokenId));
    }
    
    function testAccessControl() public {
        uint256 tokenId = 1;
        uint256 amount = 100;
        
        vm.prank(buyer);
        vm.expectRevert();
        ticketCollection.mint(buyer, tokenId, amount, "");
        
        vm.prank(buyer);
        vm.expectRevert();
        ticketCollection.checkIn(tokenId, 1);
    }
    
    function testPause() public {
        uint256 tokenId = 1;
        uint256 amount = 100;
        
        // Grant PAUSER_ROLE to test contract
        vm.prank(address(this));
        ticketCollection.grantRole(ticketCollection.PAUSER_ROLE(), address(this));
        
        ticketCollection.pause();
        
        vm.prank(minter);
        vm.expectRevert();
        ticketCollection.mint(buyer, tokenId, amount, "");
        
        ticketCollection.unpause();
        
        vm.prank(minter);
        ticketCollection.mint(buyer, tokenId, amount, "");
        assertEq(ticketCollection.balanceOf(buyer, tokenId), amount);
    }
    
    function testRoyalty() public {
        address royaltyReceiver = address(0x5);
        uint96 royaltyFee = 500; // 5%
        
        vm.prank(organizer);
        ticketCollection.setRoyaltyInfo(royaltyReceiver, royaltyFee);
        
        (address receiver, uint256 royaltyAmount) = ticketCollection.royaltyInfo(1, 1000);
        assertEq(receiver, royaltyReceiver);
        assertEq(royaltyAmount, 50); // 5% of 1000
    }
}
