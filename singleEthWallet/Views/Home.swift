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
//                Image(uiImage: Helpers.generateIdenticon(from: walletManager.wallet!.address)).resizable().frame(width: 100, height: 100).cornerRadius(10)
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
                Text(walletManager.wallet?.address ?? "")
                    .lineLimit(1)
                    .foregroundColor(Color(UIColor.ligth))
                
                Button {
                    UIPasteboard.general.string = walletManager.wallet?.address ?? ""
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
                    Task{
                        await walletManager.updateInformation()
                    }
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
                Text("subscribers 10").foregroundColor(Color(UIColor.ligth))
            }
            Divider().background(.white)
            
            ButtonsTabs(tabSelected: homeManager.tabSelected) { val in
                withAnimation {
                    homeManager.tabSelected = val
                }
            }
            
            ZStack(alignment: .top) {
                Activity(normalTransactions: walletManager.wallet?.transaction ?? [])
                    .offset(x: homeManager.tabSelected == TabSelect.activity ? 0 :  -UIScreen.main.bounds.width)
                    .transition(.move(edge: .trailing))
                
                
                
                NFTs(nfts: walletManager.wallet?.NFTs ?? [] )
                    .offset(x: homeManager.tabSelected == TabSelect.nfts ? 0 : UIScreen.main.bounds.width)
                    .transition(.move(edge: .leading))
                
            }
            .frame(maxWidth: .infinity)
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
