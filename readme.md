# NFTimable Smartcontract on Ethereum

[NFTimable](https://www.nftimable.com) is a platform that offers the possibility to buy non-fungible tokens (NFTs) created on the Ethereum Blockchain representing different categories of properties (real estate, parking, business, arts, renewable energies...).
This project is the solidity smartcontract that manages the NFTs.

## Documentation

The documentation is generated with [solidity-docgen](https://github.com/OpenZeppelin/solidity-docgen).

You can regenerate it with the following command:
```sh
npm run docify
```

personalize template with [contract.hbs](https://github.com/thierryTrolle/nftimable-smart-contract/blob/master/docgen/contract.hbs).

Current documentation can be viewed [here](https://github.com/thierryTrolle/nftimable-smart-contract/blob/master/docgen/SUMMARY.md)  (note: internal link does not work on github, prefer your markdown client).

## Feature 

Note a graphical user interface is available to test the functionalities [here](https://github.com/thierryTrolle/nftimable-front).

* `NFImableContract.createCollectible(uint256 id, uint256 amount, uint256 nftPriceUnit)` : Create NFT collection.

* `NFImableContract.buy(uint256 id, uint256 amountNFT)`: Buy NFT of collection.

* `NFImableContract.activateResellID(uint256 id, bool activate)`: activate collection for resell. NFTs can only be resold when the entire collection is sold.

* `NFImableContract.isIdActivateForResell(uint256 id)`: is activate collectible for resell, NFTs can only be resold when the entire collection is sold.  

* `NFImableContract.reSell(uint256 id, uint256 amountNFT)`: Activate a collection for resell, withdraw is manage by back when the NFT is actually resold 
        
* `NFImableContract.withdraw()`: Withdraw ETH after resold.

* `NFImableContract.transferTo(address payable addressToTransfer, uint256 amountToWithdraw)`: Transfer eth from contract to address.

* `NFTimableContractInstance.balanceOfBatch(address[] memory accounts, uint256[] memory ids)`: have accounts of NFT by user and collectionIds

## Prerequisite

you need to install the following components:
(command line is for debian system :))

* [node.js](https://nodejs.org/en/) - evented I/O for the backend and npm management package.
```sh
sudo apt-get install nodejs npm
```
* [ganache](https://www.trufflesuite.com/ganache) - a personal Ethereum blockchain for test.
```sh
sorry you must download app !
```
- [metamask](https://metamask.io/download.html) - wallet ethereum.

## Installation for dev environnement

* Start ganache with port 7545 and network id 5777

* Install dependency
```sh
npm install
```
* Compile and deploy contracts

```sh
truffle deploy --reset
```
* Start test to check installation
```sh
truffle test
```

## License
[MIT](https://choosealicense.com/licenses/mit/)
