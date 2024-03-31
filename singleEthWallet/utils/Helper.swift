//
//  Helper.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import Foundation
import UIKit
import IGIdenticon

struct Helpers {
    
     enum AppStatus {
        case initial
        case walletLoading
        case walletLoaded
        case appLoading
    }
    
    
    static func parseAmount (amount: Double) -> String {
       
        let etherValue = amount / 1e18

        return String(etherValue)
    }
    
    
//    static func generateIdenticon(from name: String) -> UIImage {
//        do {
//            let identicon = Identicon()
//            return identicon.icon(from: name, size: CGSize(width: 100, height: 100)) ?? UIImage(imageLiteralResourceName: "logo")
//        } catch {
//            return UIImage(imageLiteralResourceName: "logo")
//        }
//    }
    
    
    static func parseNFTUrl(urlString: String) -> String {
        var urlString = urlString
        if !urlString.starts(with: "https://") && !urlString.starts(with: "ipfs://") {
            urlString = "https://gateway.ipfs.chaingpt.dev/ipfs/" + urlString
        } else if urlString.starts(with: "ipfs://") {
            // Remove the "ipfs://" prefix
            urlString.removeFirst(7)
            // Prepend the base IPFS URL
            urlString = "https://gateway.ipfs.chaingpt.dev/ipfs/" + urlString
        }
        
        return urlString
    }
    
    
    static func setStorageValue<T: Encodable>(value: T, key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    static func getStorageValue<T: Decodable>(type: T.Type, key: String) -> T? {
        if let savedData = UserDefaults.standard.data(forKey: key),
           let decodedObject = try? JSONDecoder().decode(type, from: savedData) {
            return decodedObject
        }
        return nil
    }



}
