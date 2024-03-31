//
//  RPCService.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import Foundation
import web3swift
import Web3Core
import BigInt

let apiKey = "4CNWF3CRCNSUP3MQCF5UKXYZ7Z76H2KEPT"
let url = "api-sepolia.etherscan.io"


func getTransactionHistory(for address: String) async throws -> [Transaction] {
    
    let urlString = "https://\(url)/api?module=account&action=txlist&address=\(address)&startblock=0&endblock=99999999&page=1&offset=10&sort=asc&apikey=\(apiKey)"
    
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
    
    let urlString = "https://\(url)/api?module=account&action=balance&address=\(address)&tag=latest&apikey=\(apiKey)"
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


func getNFTContract (address: String) async throws -> [ERC721Transaction] {
    let urlString = "https://\(url)/api?module=account&action=tokennfttx&contractaddress=0xE6a150C75C6423e8573010A4504a099DD015c7DB&address=\(address)&page=1&offset=100&startblock=0&endblock=27025780&sort=asc&apikey=\(apiKey)"
    
    guard let url = URL(string: urlString) else {
        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(Response<[ERC721Transaction]>.self, from: data)
        return result.result
    } catch {
        return [];
    }
}

func getNFT (url: String) async throws -> NFT? {
    
    guard let url = URL(string: url) else {
        throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
    }
    
    let (data, _) = try await URLSession.shared.data(from: url)
    
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(NFT.self, from: data)
        
        return result
    } catch {
        print("Error: \(error)")
        return nil
    }
    
}



    

