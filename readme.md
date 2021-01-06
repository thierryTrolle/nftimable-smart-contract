# NFTimable smartcontract on Ethereum

NFTIMABLE is a platform that offers the possibility to buy non-fungible tokens (NFTs) created on the Ethereum Blockchain representing different categories of properties (real estate, parking, business, arts, renewable energies...).
This project is the solidity smartcontract that manages the NFTs.


## prerequisite

you need to install the following components:
command line is for debian system :)

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