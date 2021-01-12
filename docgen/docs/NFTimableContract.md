All function calls are currently implemented without side effects

# Functions:

- [`constructor()`](#NFTimableContract-constructor--)

- [`createCollectible(uint256 id, uint256 amount, uint256 nftPriceUnit)`](#NFTimableContract-createCollectible-uint256-uint256-uint256-)

- [`buy(uint256 id, uint256 amountNFT)`](#NFTimableContract-buy-uint256-uint256-)

- [`activateResellID(uint256 id, bool activate)`](#NFTimableContract-activateResellID-uint256-bool-)

- [`isIdActivateForResell(uint256 id)`](#NFTimableContract-isIdActivateForResell-uint256-)

- [`reSell(uint256 id, uint256 amountNFT)`](#NFTimableContract-reSell-uint256-uint256-)

- [`withdraw()`](#NFTimableContract-withdraw--)

- [`transferTo(address payable addressToTransfer, uint256 amountToWithdraw)`](#NFTimableContract-transferTo-address-payable-uint256-)

- [`receive()`](#NFTimableContract-receive--)

# Events:

- [`EventCreatingCollectible(uint256 id, uint256 nftPriceUnit)`](#NFTimableContract-EventCreatingCollectible-uint256-uint256-)

- [`EventBuyingCollectible(address buyer, uint256 id, uint256 amountNFT)`](#NFTimableContract-EventBuyingCollectible-address-uint256-uint256-)

- [`EventResellCollectible(address seller, uint256 id, uint256 amountNFT)`](#NFTimableContract-EventResellCollectible-address-uint256-uint256-)

- [`EventActivatedResellID(uint256 id, bool activate)`](#NFTimableContract-EventActivatedResellID-uint256-bool-)

- [`Eventwithdrawal(address addressWithdraw, uint256 amount)`](#NFTimableContract-Eventwithdrawal-address-uint256-)

- [`EventTransferTo(address addressToTransfert, uint256 amountToWithdraw)`](#NFTimableContract-EventTransferTo-address-uint256-)

# Function `constructor()` {#NFTimableContract-constructor--}

must indicate setOwnerNFT

# Function `createCollectible(uint256 id, uint256 amount, uint256 nftPriceUnit)` {#NFTimableContract-createCollectible-uint256-uint256-uint256-}

## Parameters:

- `id`: : id of collection, allows to personalise the uri to the json.

- `amount`: : number of NFT in collectible.

- `nftPriceUnit`: : price of one NFT in ETH

# Function `buy(uint256 id, uint256 amountNFT)` {#NFTimableContract-buy-uint256-uint256-}

FIXME if the customer wants to buy several NFT so you have to implement buy with safeBatchTransfer

## Parameters:

- `id`: : number of NFT in collectible.

- `amountNFT`: : price of one NFT in ETH

# Function `activateResellID(uint256 id, bool activate)` {#NFTimableContract-activateResellID-uint256-bool-}

NFTs can only be resold when the entire collection is sold. 

## Parameters:

- `id`: : id of collection.

- `activate`: : if activate, customer can resell NFT of collection.

# Function `isIdActivateForResell(uint256 id) → bool` {#NFTimableContract-isIdActivateForResell-uint256-}

NFTs can only be resold when the entire collection is sold. 

## Parameters:

- `id`: : id of collection.

## Return Values:

- true if collection activate for resell

# Function `reSell(uint256 id, uint256 amountNFT)` {#NFTimableContract-reSell-uint256-uint256-}

withdraw is manage by back when the NFT is actually resold  

## Parameters:

- `id`: : id of collection.

- `amountNFT`: : number NFT of collection to resell

# Function `withdraw()` {#NFTimableContract-withdraw--}

No description

# Function `transferTo(address payable addressToTransfer, uint256 amountToWithdraw)` {#NFTimableContract-transferTo-address-payable-uint256-}

No description

# Function `receive()` {#NFTimableContract-receive--}

No description

# Event `EventCreatingCollectible(uint256 id, uint256 nftPriceUnit)` {#NFTimableContract-EventCreatingCollectible-uint256-uint256-}

No description

# Event `EventBuyingCollectible(address buyer, uint256 id, uint256 amountNFT)` {#NFTimableContract-EventBuyingCollectible-address-uint256-uint256-}

No description

# Event `EventResellCollectible(address seller, uint256 id, uint256 amountNFT)` {#NFTimableContract-EventResellCollectible-address-uint256-uint256-}

No description

# Event `EventActivatedResellID(uint256 id, bool activate)` {#NFTimableContract-EventActivatedResellID-uint256-bool-}

No description

# Event `Eventwithdrawal(address addressWithdraw, uint256 amount)` {#NFTimableContract-Eventwithdrawal-address-uint256-}

No description

# Event `EventTransferTo(address addressToTransfert, uint256 amountToWithdraw)` {#NFTimableContract-EventTransferTo-address-uint256-}

No description
