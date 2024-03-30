//
//  Helper.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import Foundation
import UIKit
//import IGIdenticon

struct Helpers {
    
     enum AppStatus {
        case initial
        case walletLoading
        case walletLoaded
        case appLoading
    }
    
    
    static func parseAmount (amount: Double) -> String {// 50000000000000000 wei
        let etherValue = amount / 1e18

        return String(etherValue)
    }
    
    
//    static func generateIdenticon(from name: String) -> UIImage {
//        let identicon = Identicon()
//        return identicon.icon(from: name, size: CGSize(width: 100, height: 100)) ?? UIImage(imageLiteralResourceName: "logo")
//    }
}
