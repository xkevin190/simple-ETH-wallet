//
//  APIResponse.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 30/3/24.
//

import Foundation


struct Response<T: Decodable>: Decodable {
    var status: String
    var message: String
    var result: T
}

