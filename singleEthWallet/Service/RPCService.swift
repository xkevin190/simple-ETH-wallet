//
//  RPCService.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import Foundation
let apiKey = "4CNWF3CRCNSUP3MQCF5UKXYZ7Z76H2KEPT"

func getTransactionHistory(for address: String) async throws -> [Transaction] {
    
    let urlString = "https://api-sepolia.etherscan.io/api?module=account&action=txlist&address=\(address)&startblock=0&endblock=99999999&page=1&offset=10&sort=asc&apikey=\(apiKey)"
    
    guard let url = URL(string: urlString) else {
        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
    }
    
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(Response<[Transaction]>.self, from: data)
        return result.result
    } catch {
        return []
    }
}

func getBalanceAddress(for address: String) async throws -> Double {
    
    let urlString = "https://api-sepolia.etherscan.io/api?module=account&action=balance&address=\(address)&tag=latest&apikey=\(apiKey)"
    guard let url = URL(string: urlString) else {
        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)

    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(Response<String>.self, from: data)
        
        return Double(result.result) ?? 0.0
    } catch {
        return 0.0
    }
}

