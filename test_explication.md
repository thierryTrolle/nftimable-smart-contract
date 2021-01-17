# NFTimable Smartcontract Test explication

[NFTimable](https://www.nftimable.com) is a platform that offers the possibility to buy non-fungible tokens (NFTs) created on the Ethereum Blockchain representing different categories of properties (real estate, parking, business, arts, renewable energies...).
This project is the solidity smartcontract that manages the NFTs.

## Test explication
The tests are available [here](https://github.com/thierryTrolle/nftimable-smart-contract/blob/master/test/NFTimableContract.test.js)

* `Je teste la creation d'une collection`: create a collection.

* `Je que l'utilisateur ne peut pas transferer de carte avec l'interface 1155 d'origine`: verify the impossibility of doing a transaction using the original ERC1155 implementation. It is a rule of NFTimable management.

* `Je teste l'achat d'une carte`: check buying a nft, when create when you create a collection you assign it a price in ETH, when you buy a NFT you must pay NFTprice*QTnft

* `Je teste une revente et un reachat`: When you are a customer and after buying a NFT, you can resell it. You then return the card to the contract and as soon as it is resold you can withdraw your ETH.

* `Je teste le transfert d ETH vers une adresse avec transfertTo`: After having sold the cards, the ETH are withdrawn for the purchase of the property. 

* `Je teste le une requete pour visualiser les NFTs d'un utilisateur`: necessary to display the available NFTs (that of the contract) and the NFTs belonging to the customers.




