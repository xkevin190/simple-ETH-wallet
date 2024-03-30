//
//  Keychain.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import Foundation
import KeychainSwift


struct keychainModule {
    
    
  static private let keychain = KeychainSwift()

   static func save(key: String, data: String) {
        keychain.set(data, forKey: key)
    }
    
    static func load(key: String) -> String? {
        return keychain.get(key)
    }
    
    static func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }
}
