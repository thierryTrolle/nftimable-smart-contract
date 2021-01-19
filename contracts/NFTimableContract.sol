// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "./ERC1155NFTimable.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

/// @title Smart contract of NFTimable
/// @author NFTimable Team
/// @dev It's entry function of NFTimable service
contract NFTimableContract is ERC1155NFTimable, ERC1155Holder, Ownable, ReentrancyGuard{

    using SafeMath for uint256;

    /// @dev When creating collectible
    event EventCreatingCollectible(uint256 id, uint256 nftPriceUnit);

    /// @dev when customer bought a NFT
    event EventBuyingCollectible(address buyer, uint256 id,uint256 amountNFT);

    /// @dev when the customer resells a NFT
    event EventResellCollectible(address seller, uint256 id,uint256 amountNFT);

    /// @dev When owner activate the resell
    event EventActivatedResellID(uint256 id,bool activate);

    /// @dev When customer withdraw after resell
    event Eventwithdrawal(address addressWithdraw,uint256 amount);

    /// @dev  When transfert from contract to adress
    event EventTransferTo(address addressToTransfert, uint256 amountToWithdraw);

    /// @dev  Mapping from NFTid to NFTPrice in ETH
    mapping(uint256=>uint256) public nftPriceUnitById;

    /// @dev Collection activating for resell
    mapping(uint256=>bool) public idResellActivate;

    /// @dev Withdraw address=>ammount in eth
    mapping(address=>uint256) public withdrawByAddress;


    /// @dev must indicate setOwnerNFT
    constructor() public ERC1155NFTimable("https://nftimable.com/nft/{id}.json") {
        setOwnerNFT(address(this));
    }

    /// @dev Create NFT collection.
    /// @param id  id of collection, allows to personalise the uri to the json.
    /// @param amount  number of NFT in collectible.
    /// @param nftPriceUnit  price of one NFT in ETH
    function createCollectible(uint256 id, uint256 amount, uint256 nftPriceUnit) public onlyOwner{
        nftPriceUnitById[id]=nftPriceUnit;
        _mint(address(this), id, amount, "");
        emit EventCreatingCollectible(id,nftPriceUnit);
    }

    /// @dev Buy NFT of collection, FIXME if the customer wants to buy several NFT so you have to implement buy with safeBatchTransfer
    /// @param id  number of NFT in collectible.
    /// @param amountNFT  price of one NFT in ETH
    function buy(uint256 id, uint256 amountNFT) public payable allowTransfer{

        require(nftPriceUnitById[id]!=0,"NFTIMABLE:Price doesn't exist");
        uint256 price = nftPriceUnitById[id].mul(amountNFT);

        require(msg.value==price,"NFTIMABLE:the amount sent is not correct");
        
        safeTransferFrom(address(this), msg.sender, id, amountNFT, "");

        emit EventBuyingCollectible(msg.sender, id, amountNFT);

    }

    /// @dev activate collection for resell. NFTs can only be resold when the entire collection is sold. 
    /// @param id  id of collection.
    /// @param activate  if activate, customer can resell NFT of collection.
    function activateResellID(uint256 id, bool activate) public onlyOwner{
        idResellActivate[id]=activate;
        emit EventActivatedResellID(id,activate);
    }

    /// @dev is activate collectible for resell, NFTs can only be resold when the entire collection is sold. 
    /// @param id  id of collection.
    /// @return  true if collection activate for resell
    function isIdActivateForResell(uint256 id) public view returns (bool){
        return idResellActivate[id];
    }

    /// @dev activate a collection for resell, withdraw is manage by back when the NFT is actually resold  
    /// @param id  id of collection.
    /// @param amountNFT  number NFT of collection to resell
    function reSell(uint256 id, uint256 amountNFT) public allowTransfer{
        require(isIdActivateForResell(id),"NFTIMABLE:Resell not activated wet");
        
        safeTransferFrom(msg.sender, address(this), id, amountNFT, "");

        uint256 price = nftPriceUnitById[id].mul(amountNFT);
        withdrawByAddress[msg.sender]=withdrawByAddress[msg.sender].add(price);

        emit EventResellCollectible(msg.sender, id,amountNFT);
    }

    /// @dev withdraw ETH after resold.
    function withdraw() public nonReentrant{
        require(withdrawByAddress[msg.sender]>=0,"NFTIMABLE:Nothing to refund");
        require(address(this).balance>withdrawByAddress[msg.sender],"NFTIMABLE:Not enought amount to withdraw");

        uint256 amountToWithdraw=withdrawByAddress[msg.sender];
        msg.sender.transfer(amountToWithdraw);

        withdrawByAddress[msg.sender]=0;

        Eventwithdrawal(msg.sender,amountToWithdraw);
    }

    /// @dev transfer eth from contract to address
    /// @param addressToTransfer  address that receives the funds  
    /// @param amountToWithdraw  amount in ETH
    function transferTo(address payable addressToTransfer, uint256 amountToWithdraw) public onlyOwner nonReentrant (){
        require(address(this).balance>=amountToWithdraw,"NFTIMABLE:Not enought amount to transfertTo");
        addressToTransfer.transfer(amountToWithdraw);
        emit EventTransferTo(addressToTransfer, amountToWithdraw);
    }

     //payable obligation
    receive() external payable {
    }
}