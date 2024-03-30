//
//  Home.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import SwiftUI
import IGIdenticon

struct Home: View {
    @EnvironmentObject private var walletManager: WalletViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(UIColor.night).ignoresSafeArea()
            VStack{
                
                VStack {
                    
                    Image("Logo")
                        .resizable()
                        .cornerRadius(10)
                    
                }
                .frame(
                    width: 100,
                    height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/
                )
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color(UIColor.ligth))
                )
                
                Spacer()
            }
            .frame(
                maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                maxHeight: UIScreen.main.bounds.height * 0.4,
                alignment: .leading
                
            )
            
        }
    }
}




#Preview {
    Home()
        .environmentObject(WalletViewModel())
}
