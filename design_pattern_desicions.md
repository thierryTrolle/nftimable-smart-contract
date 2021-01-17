# NFTimable Smartcontract design Pattern

[NFTimable](https://www.nftimable.com) is a platform that offers the possibility to buy non-fungible tokens (NFTs) created on the Ethereum Blockchain representing different categories of properties (real estate, parking, business, arts, renewable energies).More information in our [white paper](https://github.com/thierryTrolle/nftimable-smart-contract/blob/master/white_paper_v1.pdf).

## Design pattern choice :
NFTimable uses NFT, after studying different standards it appeared that the [ERC-1155](https://eips.ethereum.org/EIPS/eip-1155) created by ENJIN was the most suitable for our needs: 

* It allows us to create fungible and non-fungible tokens in the same collection, which would allow us to manage token rewards.

* It allows you to manage dynamic data because it points to a json file that can be modified and evolve over time, e.g. generation of the latest annuities. 

* Today the biggest concern on the Ethereum network are the transaction costs, the 1155 standard allows the transfer of several NFTs of different collections in the same transaction which is a fundamental point in the adoption of the solution.


However, the original ERC1155 implementation does not respect NFTimable's management rules because it only allows the transfer to the card owner and the address chosen by the user. This is a problem because NFTimable wants the transactions to be secured by its contract and only by its contract. 

For this NFTimable has created its own implementation of the ERC-1155 and strictly  respects the methods signatures of the original implementation: [ERC1155NFTimable](https://github.com/thierryTrolle/nftimable-smart-contract/blob/master/contracts/ERC1155NFTimable.sol).

The main changes are the modification of :
* the isApprovedForAll method which allows only a transfer to/from the contract.

* the safeTransferFrom and safeBatchTransferFrom methods check that the allowTransfer modifier is used, this prevents that the one who knows the original ERC1155 imlementation can do the transfer. Transfer can be used while by the buy and resell method of NFTimableContract.

* the contract must hold the nft, it must inherit from ERC1155Holder.

* The contract uses for the code security the [openzeppelin](https://github.com/OpenZeppelin) library, see SafeMath Ownable ReentrancyGuard.

