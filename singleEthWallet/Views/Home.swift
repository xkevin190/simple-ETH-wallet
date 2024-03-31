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
    @StateObject var homeManager = HomeViewModel()
    
    var body: some View {
        ZStack{
            Color(UIColor.night).ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                WalletInformation()
            }
            
        }
    }
    
    
    
    // MARK: - Wallet Information
    
    @ViewBuilder func WalletInformation() -> some View {
        VStack(alignment: .leading, spacing: 10){
            
            VStack() {
                Image(uiImage: Helpers.generateIdenticon(from: walletManager.wallet!.address)).resizable().frame(width: 100, height: 100).cornerRadius(10)
                
            }
            .frame(
                width: 100,
                height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/
            )
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color(UIColor.ligth))
            )
            
            Text("Ethereum Wallet")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            HStack {
                Text("0xC16E9B216E57d5B72fB38dAc3e64A28B6DC06528")
                    .lineLimit(1)
                    .foregroundColor(Color(UIColor.ligth))
                
                Button {
                    UIPasteboard.general.string = "0xC16E9B216E57d5B72fB38dAc3e64A28B6DC06528"
                } label: {
                    VStack {
                        Image(systemName: "doc.on.doc").padding(10)
                            .foregroundColor(Color(UIColor.ligth))
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color(UIColor.box))
                    )
                }
            }
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed mollis laoreet leo sed mollis. Aliquam et posuere odio")
                .lineLimit(1)
                .foregroundColor(Color(UIColor.ligth))
            
            HStack {
                VStack(spacing: 5) {
                    Text("Balance").foregroundColor(.white).fontWeight(.semibold)
                    Text(Helpers.parseAmount(amount: walletManager.wallet!.balance ))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Spacer()
                
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "arrow.clockwise").padding(10)
                            .foregroundColor(.white)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color(UIColor.jet))
                    )
                }
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
            .padding()
            .background(Color(UIColor.box))
            .cornerRadius(10)
            
            HStack {
                Text("Subscriptions 0").foregroundColor(Color(UIColor.ligth))
                Text("subscriber 10").foregroundColor(Color(UIColor.ligth))
            }
            Divider().background(.white)
            
            ButtonsTabs(tabSelected: homeManager.tabSelected) { val in
                withAnimation {
                    homeManager.tabSelected = val
                }
            }
            
            if (homeManager.tabSelected == TabSelect.activity ) {
                Activity(normalTransactions: walletManager.wallet?.transaction ?? [])
                    .transition(.move(edge: .leading))
            }
            
            if (homeManager.tabSelected == TabSelect.nfts ) {
                NFTs()
                    .transition(.move(edge: .trailing))
            }
            
            Spacer()
        }
        
        .frame(
            maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/
        )
        .padding(.horizontal)
    }
}


#Preview {
    Home()
        .environmentObject(WalletViewModel())
}
