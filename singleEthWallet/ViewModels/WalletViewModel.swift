//
//  WalletViewModel.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import Foundation
import web3swift
import Web3Core
import SwiftUI


class WalletViewModel: ObservableObject {
    
    @Published var wallet: EthereumWallet?
    @Published var createWalletLoading: Bool = false
    @Published var AppStatus = Helpers.AppStatus.appLoading
    
    private var httpRequest = HttpRequest()
    
    
    func updateInformation() async {
        if (wallet != nil) {
            do {
                let value = try await httpRequest.getBalanceAddress(for: wallet!.address)
                let transactionHistory = try await httpRequest.getTransactionHistory(for: wallet!.address)
                let rawNFTTrasactions = try await httpRequest.getNFTContract(address: wallet!.address)
                let parsedNFTData =  await EthereumWallet.ReadNFTContract(data: rawNFTTrasactions, httpRequest: httpRequest)
                
            
                DispatchQueue.main.async {
                    self.wallet?.updateBalance(newBalance: value)
                    self.wallet?.updateTransaction(newTransactions: transactionHistory)
                    self.wallet?.updateNFTs(newNfts: parsedNFTData)
                }
                
            } catch {
                print("Error updating information")
            }
            
        }
        
    }
    
    
    
    func createWallet() {
        Task{
            DispatchQueue.main.async {
                self.createWalletLoading.toggle()
                self.AppStatus = Helpers.AppStatus.walletLoading
            }
            let tempMnemonics = EthereumWallet.createMnemonics()
            guard let tMnemonics = tempMnemonics else {
                DispatchQueue.main.async {
                    self.createWalletLoading.toggle()
                    self.AppStatus = Helpers.AppStatus.initial
                }
                
                print("We are unable to create wallet")
                return
            }
            
            let tempWalletAddress = EthereumWallet.GenerateBIT32Keystore(tMnemonics: tMnemonics)
            guard let walletAddress = tempWalletAddress?.addresses?.first else {
                DispatchQueue.main.async {
                    self.createWalletLoading.toggle()
                    self.AppStatus = Helpers.AppStatus.initial
                }
                
                print("Unable to create wallet")
                return
            }
            
            let privateKey = EthereumWallet.getPrivateKey(address: walletAddress, tempAddress: tempWalletAddress!)
            
            let value = try await httpRequest.getBalanceAddress(for: walletAddress.address)
            let transactionHistory = try await httpRequest.getTransactionHistory(for: walletAddress.address)
            let rawNFTTrasactions = try await httpRequest.getNFTContract(address: walletAddress.address)
            let parsedNFTData =  await EthereumWallet.ReadNFTContract(data: rawNFTTrasactions, httpRequest: httpRequest)
            
            Helpers.setStorageValue(value: value, key: "balance")
            Helpers.setStorageValue(value: transactionHistory, key: "transaction")
            Helpers.setStorageValue(value: parsedNFTData, key: "nfts")
            
            DispatchQueue.main.async {
                withAnimation {
                    self.self.createWalletLoading.toggle()
                    self.wallet = EthereumWallet(address: walletAddress.address, balance: value, privateKey: privateKey!, transactions: transactionHistory, NFTs: parsedNFTData)
                    self.AppStatus = Helpers.AppStatus.walletLoaded
                    keychainModule.save(key: "Mnemonics", data: tMnemonics)
                }
            }
        }
    }
    
    func loadEthWallet() async {
        Task{
            let mnemonics = keychainModule.load(key: "Mnemonics") ?? nil
            print(mnemonics)
            if (mnemonics != nil) {
                guard let tempWalletAddress = EthereumWallet.GenerateBIT32Keystore(tMnemonics: mnemonics!),
                      let walletAddress = tempWalletAddress.addresses?.first,
                      let privateKey = EthereumWallet.getPrivateKey(address: walletAddress, tempAddress: tempWalletAddress) else {
                    self.AppStatus = Helpers.AppStatus.initial
                    return
                }
                
                
                do {
                    let value = try await httpRequest.getBalanceAddress(for: walletAddress.address)
                    let transactionHistory = try await httpRequest.getTransactionHistory(for: walletAddress.address)
                    let rawNFTTrasactions = try await httpRequest.getNFTContract(address: walletAddress.address)
                    let parsedNFTData =  await EthereumWallet.ReadNFTContract(data: rawNFTTrasactions,  httpRequest: httpRequest)
                
                    /// save the fechet in the  phone storage
                     
                    Helpers.setStorageValue(value: value, key: "balance")
                    Helpers.setStorageValue(value: transactionHistory, key: "transaction")
                    Helpers.setStorageValue(value: parsedNFTData, key: "nfts")
                    
                    DispatchQueue.main.async {
                        
                        self.wallet = EthereumWallet(address: walletAddress.address, balance: value, privateKey: privateKey, transactions: transactionHistory, NFTs: parsedNFTData)
                        self.AppStatus = Helpers.AppStatus.walletLoaded
                    }
                } catch {
                    let value: Double = Helpers.getStorageValue(type: Double.self, key: "nfts") ?? 0.0
                    let transactionHistory: [Transaction] = Helpers.getStorageValue(type: [Transaction].self, key: "transaction") ?? []
                    
                    let parsedNFTData: [NFT] =  Helpers.getStorageValue(type: [NFT].self, key: "nfts") ?? []
                    DispatchQueue.main.async {
                        
                        self.wallet = EthereumWallet(address: walletAddress.address, balance: value, privateKey: privateKey, transactions: transactionHistory, NFTs: parsedNFTData)
                        self.AppStatus = Helpers.AppStatus.walletLoaded
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.AppStatus = Helpers.AppStatus.initial
                }
            }
        }
    }
}
