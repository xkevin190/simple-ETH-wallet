//
//  EthWallet.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import Foundation
import web3swift
import Web3Core

struct EthereumWallet {
    let address: String
    let privateKey: Data
    var balance: Double
    
    // Other properties like tokens, transactions, etc. can be added here
    
    init(address: String, balance: Double, privateKey: Data) {
        self.address = address
        self.balance = balance
        self.privateKey = privateKey
    }
    
    mutating func updateBalance(newBalance: Double) {
        self.balance = newBalance
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
    
}
