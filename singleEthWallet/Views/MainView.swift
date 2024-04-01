//
//  MainView.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var walletViewModal = WalletViewModel()
    var body: some View {
        
        ZStack {
            if(walletViewModal.AppStatus == Helpers.AppStatus.appLoading) {
                Welcome()
            }
            
            else if walletViewModal.AppStatus == Helpers.AppStatus.initial || walletViewModal.AppStatus == Helpers.AppStatus.walletLoading {
                CreateWallet()
                    .transition(.move(edge: .leading))
                    .environmentObject(walletViewModal)
            }
            
            if(walletViewModal.wallet != nil ) {
                Home()
                    .environmentObject(walletViewModal)
                    .transition(.move(edge: .trailing))
            }
        }
        .onAppear(){
            Task {
                await  walletViewModal.loadEthWalletWithMnemonicts()
            }
        }
    }
    
}

#Preview {
    MainView()
}
