Implementation of the basic standard multi-token.

See https://eips.ethereum.org/EIPS/eip-1155

Originally based on code by Enjin: https://github.com/enjin/erc-1155

_Available since v3.1._

# Functions:

- [`constructor(string uri_)`](#ERC1155NFTimable-constructor-string-)

- [`uri(uint256)`](#ERC1155NFTimable-uri-uint256-)

- [`balanceOf(address account, uint256 id)`](#ERC1155NFTimable-balanceOf-address-uint256-)

- [`balanceOfBatch(address[] accounts, uint256[] ids)`](#ERC1155NFTimable-balanceOfBatch-address---uint256---)

- [`setApprovalForAll(address operator, bool approved)`](#ERC1155NFTimable-setApprovalForAll-address-bool-)

- [`isApprovedForAll(address account, address operator)`](#ERC1155NFTimable-isApprovedForAll-address-address-)

- [`safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes data)`](#ERC1155NFTimable-safeTransferFrom-address-address-uint256-uint256-bytes-)

- [`safeBatchTransferFrom(address from, address to, uint256[] ids, uint256[] amounts, bytes data)`](#ERC1155NFTimable-safeBatchTransferFrom-address-address-uint256---uint256---bytes-)

# Events:

- [`EventSetApprovalForAll(address operator, bool approved)`](#ERC1155NFTimable-EventSetApprovalForAll-address-bool-)

- [`EventIsApprovedForAll(address account, address operator)`](#ERC1155NFTimable-EventIsApprovedForAll-address-address-)

# Function `constructor(string uri_)` {#ERC1155NFTimable-constructor-string-}

See {_setURI}.

# Function `uri(uint256) → string` {#ERC1155NFTimable-uri-uint256-}

See {IERC1155MetadataURI-uri}.

This implementation returns the same URI for *all* token types. It relies

on the token type ID substitution mechanism

https://eips.ethereum.org/EIPS/eip-1155#metadata[defined in the EIP].

Clients calling this function must replace the `\{id\}` substring with the

actual token type ID.

# Function `balanceOf(address account, uint256 id) → uint256` {#ERC1155NFTimable-balanceOf-address-uint256-}

See {IERC1155-balanceOf}.

Requirements:

- `account` cannot be the zero address.

# Function `balanceOfBatch(address[] accounts, uint256[] ids) → uint256[]` {#ERC1155NFTimable-balanceOfBatch-address---uint256---}

See {IERC1155-balanceOfBatch}.

Requirements:

- `accounts` and `ids` must have the same length.

# Function `setApprovalForAll(address operator, bool approved)` {#ERC1155NFTimable-setApprovalForAll-address-bool-}

See {IERC1155-setApprovalForAll}.

# Function `isApprovedForAll(address account, address operator) → bool` {#ERC1155NFTimable-isApprovedForAll-address-address-}

See {IERC1155-isApprovedForAll}.

Allows only transfers to or from OwnerNFT

All transfers are managed by NFTimableContract with the attribute lockedTransfert

# Function `safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes data)` {#ERC1155NFTimable-safeTransferFrom-address-address-uint256-uint256-bytes-}

See {IERC1155-safeTransferFrom}.

# Function `safeBatchTransferFrom(address from, address to, uint256[] ids, uint256[] amounts, bytes data)` {#ERC1155NFTimable-safeBatchTransferFrom-address-address-uint256---uint256---bytes-}

See {IERC1155-safeBatchTransferFrom}.

# Event `EventSetApprovalForAll(address operator, bool approved)` {#ERC1155NFTimable-EventSetApprovalForAll-address-bool-}

No description

# Event `EventIsApprovedForAll(address account, address operator)` {#ERC1155NFTimable-EventIsApprovedForAll-address-address-}

No description
