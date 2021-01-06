// contracts/GameItems.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

// import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
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

    //when customer approve
    event EventApprove(address approvedAddress);
    

    //to test FIXME 
    event EventControl(address owner, address caller);

    // address private NFTowner=0xeFaA9e4492B3E352c7baDdFc3AA11e22BFB3C59E;

    //Mapping from idNft to nftPrice in ETH
    mapping(uint256=>uint256) public nftPriceUnitById;

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
        require(nftPriceUnitById[id]!=0,"Price doesn't exist");
        uint256 price = nftPriceUnitById[id].mul(amountNFT);

        require(msg.value==price,"not enought amount");

        lockedTransfert=false;
        safeTransferFrom(address(this), msg.sender, id, amountNFT, "");
        lockedTransfert=true;

        emit EventBuyingCollectible(msg.sender, id, amountNFT);

    }

    //Customer want to resell NFT
    function reSell() public {
        
    }

     //payable obligation
    receive() external payable {
    }
}