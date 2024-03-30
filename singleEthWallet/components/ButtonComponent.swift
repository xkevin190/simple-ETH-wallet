//
//  ButtonComponent.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import SwiftUI

struct ButtonComponent: View {
    var loading: Bool
    var actionCreate: ()-> Void
    
    var body: some View {
        Button {
            withAnimation {
                actionCreate()
            }
        } label: {
            VStack {
                
                if loading { ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .padding()
                }
                if !loading {
                    Text("Create Wallet")
                        .fontWeight(.semibold)
                        .foregroundColor(Color(UIColor.ligth)).padding()
                }
            }
            .disabled(loading)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color(UIColor.night2))
            )
            .padding(.horizontal)
            
        }
    }
}

