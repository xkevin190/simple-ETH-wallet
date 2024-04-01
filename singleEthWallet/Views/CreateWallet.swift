//
//  CreateWallet.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import SwiftUI

struct CreateWallet: View {
    @State var appLoaded = false
    @EnvironmentObject private var walletManager: WalletViewModel
    
    var body: some View {
        VStack(spacing: 15){
            VStack {
                Image("Logo").resizable().frame(width: 300, height: 300)
            }
            .frame(
                height: UIScreen.main.bounds.size.height * 0.75
            )
            
            ButtonComponent(Title: "Create Wallet", loading: walletManager.createWalletLoading) {
                walletManager.createWallet()
            }
            
            ButtonComponent(Title: "Load Wallet", loading: walletManager.loadDefaultWalletLoading) {
                Task {
                    await walletManager.createWalletWithMnemonic(mnemonics: "release quantum regret breeze tobacco lazy when enrich old drum latin tag yard estate opinion illegal between green borrow alpha quit pride economy actual")
                }
               
            }
            .padding(.bottom)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color(UIColor.night))
      
        
    }
}


#Preview {
    Welcome().environmentObject(WalletViewModel())
}
