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
            
            print("arrive here!!!!", walletAddress.address)
            
            DispatchQueue.main.async {
                withAnimation {
                    self.self.createWalletLoading.toggle()
                    self.wallet = EthereumWallet(address: walletAddress.address, balance: 0.0, privateKey: privateKey!)
                    self.AppStatus = Helpers.AppStatus.walletLoaded
                    keychainModule.save(key: "Mnemonics", data: tMnemonics)
                }
            }
        }
    }
    
    
    
    func loadEthWallet() {
        Task{
            let mnemonics = keychainModule.load(key: "Mnemonics") ?? nil
            if (mnemonics != nil) {
                guard let tempWalletAddress = EthereumWallet.GenerateBIT32Keystore(tMnemonics: mnemonics!),
                      let walletAddress = tempWalletAddress.addresses?.first,
                      let privateKey = EthereumWallet.getPrivateKey(address: walletAddress, tempAddress: tempWalletAddress) else {
                    self.AppStatus = Helpers.AppStatus.initial
                    return
                }
                DispatchQueue.main.async {
                    withAnimation {
                        self.wallet = EthereumWallet(address: walletAddress.address, balance: 0.0, privateKey: privateKey)
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
