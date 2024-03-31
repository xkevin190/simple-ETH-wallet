//
//  Cards.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import SwiftUI

struct Cards: View {
    var from: String
    var confirmations: String
    var TXID: String
    var amount: Double
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image(uiImage: Helpers.generateIdenticon(from: from)).resizable().frame(width: 50, height: 50 ).background(.white).cornerRadius(10)
                
                VStack(alignment: .leading){
                    Text("From: \(from)").foregroundColor(.white).lineLimit(1)
                    Text("Confirmations: \(confirmations)").foregroundColor(.white)

                    Button {
                        UIApplication.shared.open(URL(string: "https://sepolia.etherscan.io/tx/\(TXID)")!)
                    } label: {
                        Text("TxID : \(TXID)").lineLimit(1)
                    }
                    
                }
            }.padding()
            Divider().background(.white)
            VStack{
                Text("Received  \(Helpers.parseAmount(amount: amount)) ETH").foregroundColor(Color(UIColor.ligth)).padding()
            }
            .background(Color(UIColor.jet))
            .cornerRadius(10)
            .padding(.bottom, 10)
            .padding(.top, 5)
            .padding(.horizontal)
        }
        
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
        .background(Color(UIColor.box))
        .cornerRadius(10)
        
    }
}

