//
//  Activity.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import SwiftUI

struct Activity: View {
    
    var normalTransactions: [Transaction]
    var body: some View {

        ForEach(normalTransactions, id: \.hash) { transaction in
            Cards(from: transaction.from, confirmations: transaction.confirmations, TXID: transaction.hash, amount: Double(transaction.value) ?? 0.0)
        }
        
    }
}

#Preview {
    Activity(normalTransactions: [])
}
