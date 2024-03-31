//
//  Transactions.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import Foundation



struct ERC721Transaction: Codable {
    let blockNumber: String
    let timeStamp: String
    let hash: String
    let nonce: String
    let blockHash: String
    let from: String
    let contractAddress: String
    let to: String
    let tokenID: String
    let tokenName: String
    let tokenSymbol: String
    let tokenDecimal: String
    let transactionIndex: String
    let gas: String
    let gasPrice: String
    let gasUsed: String
    let cumulativeGasUsed: String
    let input: String
    let confirmations: String
}


struct Transaction: Codable {
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


struct NFT: Codable  {
    
    let name: String
    let description: String
    let image: String
}
