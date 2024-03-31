//
//  EthWallet.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import Foundation
import web3swift
import Web3Core
import BigInt

struct EthereumWallet: Codable  {
    let address: String
    var balance: Double
    var transaction: [Transaction]
    var NFTs: [NFT];

    

    init(address: String, balance: Double, privateKey: Data?, transactions: [Transaction], NFTs:[NFT]) {
        self.address = address
        self.balance = balance
        self.transaction = transactions
        self.NFTs = NFTs
    }
    
    mutating func updateBalance(newBalance: Double) {
        self.balance = newBalance
    }
    
    mutating func updateTransaction(newTransactions: [Transaction]) {

        self.transaction = newTransactions
    }
    
    
    mutating func updateNFTs (newNfts: [NFT]) {
        self.NFTs = newNfts
    }
}


extension EthereumWallet {
    
    static func createMnemonics () -> String? {
        let mnemonics = try? BIP39.generateMnemonics(bitsOfEntropy: 256, language: .english) ?? nil
        return mnemonics
    }
    
    static func GenerateBIT32Keystore (tMnemonics: String) -> BIP32Keystore? {
        let tempWalletAddress = try? BIP32Keystore(mnemonics: tMnemonics, password: "", prefixPath: "m/44'/77777'/0'/0")
        
        return tempWalletAddress
    }
    
    static func getWalletAddress (tempAddress: BIP32Keystore) -> EthereumAddress? {
        let walletAddress = tempAddress.addresses?.first ?? nil
        
        return walletAddress
    }
    
    static func getPrivateKey (address: EthereumAddress, tempAddress: BIP32Keystore) -> Data? {
        let privateKey = try? tempAddress.UNSAFE_getPrivateKeyData(password: "", account: address)
        return privateKey
    }
    
    
    static  func ReadNFTContract (data: [ERC721Transaction], httpRequest: HttpRequest) async -> [NFT] {
        do {
            let web3 = try await Web3.new(URL(string: "https://sepolia.drpc.org")!)
            let contract = web3.contract(Web3.Utils.erc721ABI, at: EthereumAddress("0xe6a150c75c6423e8573010a4504a099dd015c7db")!)!
            var NFTs: [NFT] = []
            for transaction in data {
                
                if let tokenID = BigInt(transaction.tokenID) {
                    // Call the tokenURI method of the contract
                    let result = try await contract.createReadOperation("tokenURI", parameters: [tokenID])?.callContractMethod()
                    if let unwrappedResult = result, let link = unwrappedResult["0"] as? String {
                        let nft =  try await httpRequest.getNFT(url:Helpers.parseNFTUrl(urlString: link))
                    
                        if(nft != nil){
                            NFTs.append(nft!)
                        }
                        
                    }
                }
            }
            
            
            return NFTs
        } catch {
            return []
        }
    }
}
