//
//  Color.swift
//  singleEthWallet
//
//  Created by Kevin Velasco on 29/3/24.
//

import Foundation
import UIKit


extension UIColor {
    static let raisinBlack = UIColor(hex: "#141917")
    static let night = UIColor(hex: "#1C1E23")
    static let jet = UIColor(hex: "#1c2321")
    static let night2 = UIColor(hex: "#141619")
    static let davysGray = UIColor(hex: "#1d1d23")
    static let ligth = UIColor(hex: "#e6f1ff")
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var formattedHex = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if formattedHex.hasPrefix("#") {
            formattedHex.remove(at: formattedHex.startIndex)
        }
        var rgbValue: UInt64 = 0
        Scanner(string: formattedHex).scanHexInt64(&rgbValue)
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
