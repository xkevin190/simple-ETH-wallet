## Simple Wallet ETH

Welcome to the Ethereum Wallet! This application is a test app designed to showcase the functionality of viewing Ethereum (ETH) wallet data without the capability to send transactions. It provides a environment for users to explore their Ethereum balances, transaction history, and view NFT (Non-Fungible Token) tokens associated with their wallet.


### Ethereum Wallet (SwiftUI) - Application Overview

The Ethereum Wallet application is built using SwiftUI and adheres to the MVVM (Model-View-ViewModel) architecture pattern. To maintain simplicity, the application has been implemented with a single ViewModel that handles most of the functionalities. 

### Application States

1) **Welcome Screen:** Upon initial installation, users encounter a welcome screen presenting two primary buttons.
"Create New Wallet": Initiates the process of creating a new Ethereum wallet.
"Load Default Wallet": Offers users the option to load a predefined wallet tailored for testing purposes.


2) **Home Screen**:The central hub of the application, the Home screen, provides users with crucial wallet information and functionalities.
Features Include:
Display of Ethereum wallet address.
Visualization of Ethereum balance.
Transaction history showcasing incoming and outgoing transactions.
NFT section, presenting any non-fungible tokens associated with the wallet.


### External Libs Used

1) **Web3Swift**: I used this library due to its simplicity and because it contained all the necessary features to create the wallet and read the ERC721 contract for NFTs.

2) **KeyChainSwift**: KeychainSwift is a library that allowed us to easily and securely store the 24 recovery words.


### Storage methods

For storing data in this application, the following methods were used:

1) **UserDefaults**: Here, non-sensitive data such as transaction history of the wallet, balance, and URLs of NFT images are stored. This allows the application to function even without an internet connection.

2) **KeychainSwift**: Once the wallet is created, the mnemonic is stored in Apple's Keychain for quick and secure loading of the wallet when the application is closed and reopened.


## Test video about hot the aplication is working on:

https://github.com/xkevin190/simple-ETH-wallet/assets/37220428/afdc3dde-1843-436f-9659-e296f373066e



