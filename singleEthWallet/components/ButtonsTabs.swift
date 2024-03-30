//
//  ButtonsTabs.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import SwiftUI

struct ButtonsTabs: View {

    var tabSelected: TabSelect;
    var action: (_ value : TabSelect) -> Void;
    
    var body: some View {
        HStack {
            Button {
                action(TabSelect.activity)
            } label: {
                Text("Activity")
                    .padding()
                    .foregroundColor(tabSelected == TabSelect.nfts ? .gray : .white)
            }
            .frame(maxWidth: .infinity)
            .background(tabSelected == TabSelect.nfts ? Color(UIColor.night) : Color(UIColor.box))
            .cornerRadius(10)
            
            Button {
                action(TabSelect.nfts)
            } label: {
                Text("NFTs").padding()
                    .foregroundColor(tabSelected == TabSelect.activity ? .gray : .white)
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(tabSelected == TabSelect.activity ? Color(UIColor.night) : Color(UIColor.box))
            .cornerRadius(10)
            
            
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
       
    }
}

#Preview {
    Home()
        .environmentObject(WalletViewModel())
}
