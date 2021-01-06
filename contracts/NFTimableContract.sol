// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./ERC1155NFTimable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";


contract NFTimableContract is ERC1155NFTimable, ERC1155Holder, Ownable, ReentrancyGuard{

    using SafeMath for uint256;

    //When creating collectible
    event EventCreatingCollectible(uint256 id, uint256 nftPriceUnit);

    //when customer bought a NFT
    event EventBuyingCollectible(address buyer, uint256 id,uint256 amountNFT);

    //when the customer resells a NFT
    event EventResellCollectible(address seller, uint256 id,uint256 amountNFT);

    //When owner activate the resell
    event EventActivatedResellID(uint256 id,bool activate);

    event Eventwithdrawal(address addressWithdraw,uint256 amount);

    //Mapping from NFTid to NFTPrice in ETH
    mapping(uint256=>uint256) public nftPriceUnitById;

    //Collection activating for resell
    mapping(uint256=>bool) public idResellActivate;

    //Withdraw address=>ammount in eth
    mapping(address=>uint256) public withdrawByAddress;

    constructor() public ERC1155NFTimable("https://nftimable.com/nft/{id}.json") {
        setOwnerNFT(address(this));
        lockedTransfert=true;
    }

    /**
     * @dev Create NFT with id and amount
     */
    function createCollectible(uint256 id, uint256 amount, uint256 nftPriceUnit) public onlyOwner{
        nftPriceUnitById[id]=nftPriceUnit;
        _mint(address(this), id, amount, "");
        emit EventCreatingCollectible(id,nftPriceUnit);
    }

    /**
     * Buy collectible 
     */
    function buy(uint256 id, uint256 amountNFT) public payable nonReentrant{

        // emit EventControl(owner(), msg.sender);
        require(nftPriceUnitById[id]!=0,"NFTIMABLE:Price doesn't exist");
        uint256 price = nftPriceUnitById[id].mul(amountNFT);

        require(msg.value==price,"NFTIMABLE:Not enought amount");

        lockedTransfert=false;
        safeTransferFrom(address(this), msg.sender, id, amountNFT, "");
        lockedTransfert=true;

        emit EventBuyingCollectible(msg.sender, id, amountNFT);

    }

    //activate collection for resell
    function activateResellID(uint256 id, bool activate) public onlyOwner{
        idResellActivate[id]=activate;
        emit EventActivatedResellID(id,activate);
    }

    //check if collection open to resell
    function isIdActivateForResell(uint256 id) public view returns (bool){
        return idResellActivate[id];
    }

    //Customer want to resell NFT
    function reSell(uint256 id, uint256 amountNFT) public nonReentrant {
        require(isIdActivateForResell(id),"NFTIMABLE:Resell not activated wet");
        
        lockedTransfert=false;
        safeTransferFrom(msg.sender, address(this), id, amountNFT, "");
        lockedTransfert=true;

        uint256 price = nftPriceUnitById[id].mul(amountNFT);
        withdrawByAddress[msg.sender]=withdrawByAddress[msg.sender].add(price);

        emit EventResellCollectible(msg.sender, id,amountNFT);
    }

    //customer withdrawal 
    function withdraw() public nonReentrant{
        require(withdrawByAddress[msg.sender]>0,"NFTIMABLE:Nothing to refund");
        require(address(this).balance>withdrawByAddress[msg.sender],"NFTIMABLE:Not enought amount to withdraw");

        uint256 amountToWithdraw=withdrawByAddress[msg.sender];
        msg.sender.transfer(amountToWithdraw);

        withdrawByAddress[msg.sender]=0;

        Eventwithdrawal(msg.sender,amountToWithdraw);

    }

     //payable obligation
    receive() external payable {
    }
}