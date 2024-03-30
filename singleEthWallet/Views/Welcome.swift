//
//  Welcome.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import SwiftUI

struct Welcome: View {
    @State var appLoaded = false
    @EnvironmentObject private var walletManager: WalletViewModel
    
    var body: some View {
        VStack(spacing: 15){
            Image("Logo").resizable().frame(width: 300, height: 300)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color(UIColor.night))
        
    }
}

#Preview {
    Welcome()
        .environmentObject(WalletViewModel())
}
