//
//  Transactions.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import Foundation


struct Transaction: Decodable {
    var blockNumber: String
    var timeStamp: String
    var hash: String
    var nonce: String
    var blockHash: String
    var transactionIndex: String
    var from: String
    var to: String
    var value: String
    var gas: String
    var gasPrice: String
    var isError: String
    var txreceipt_status: String
    var input: String
    var contractAddress: String
    var cumulativeGasUsed: String
    var gasUsed: String
    var confirmations: String
    var methodId: String
    var functionName: String
}
