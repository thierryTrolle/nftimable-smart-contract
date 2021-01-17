# NFTimable Smartcontract

[NFTimable](https://www.nftimable.com) is a platform that offers the possibility to buy non-fungible tokens (NFTs) created on the Ethereum Blockchain representing different categories of properties (real estate, parking, business, arts, renewable energies...).
This project is the solidity smartcontract that manages the NFTs.

## Avoiding common attack

 Note the current version is a POC and does not reflect the final version: This code is not guaranteed.

* The contract uses for the code security the [openzeppelin](https://github.com/OpenZeppelin) library, see SafeMath Ownable ReentrancyGuard. The version used is not audited but the previous version is. The code will still need to be audited before deployment.

* NFTimableContract.createCollectible can call by only owner

* NFTimableContract.buy/NFTimableContract.resell : precaution for the transfer which is only possible for all methods that use allowTransfer modifier. To prevent reentrancy allowTransfer uses a require of the atomic state _unlockedTransfer in ERC1155NFTimable.


* NFTimableContract.withdraw() : use nonReentrant protection.

* NFTimableContract.transferTo() : use onlyOwner nonReentrant.
