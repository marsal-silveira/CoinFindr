//
//  UIColor+.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit

// ************************************* //
// MARK: From RGB | Hexa
// ************************************* //

extension UIColor {

    public class func RGBColor(_ hexColor: String, alpha: CGFloat = 1.0) -> UIColor {
        
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var hexColorCode = hexColor as String
        hexColorCode += hexColorCode.hasPrefix("#") ? "" : "#"
        
        let index = hexColorCode.index(hexColorCode.startIndex, offsetBy: 1)
        let hex = hexColorCode.substring(from: index)
        let scanner = Scanner(string: hex)
        var hexValue: CUnsignedLongLong = 0
        
        if scanner.scanHexInt64(&hexValue) {
            
            if hex.count == 6 {
                
                red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                blue = CGFloat(hexValue & 0x0000FF) / 255.0
            }
            else if hex.count == 8 {
                
                red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
            }
        }
        
        return UIColor(red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha: alpha)
    }
    
    public class func UIColorFromHex(_ rgbValue: UInt32, alpha: Double = 1.0) -> UIColor {
        
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
    
// ************************************* //
// MARK: Predefined Colors
// ************************************* //

extension UIColor {
    
    public class var customBlue: UIColor {
        return UIColor.RGBColor("#1B7AFE")
    }
    
    public class var bgPlaceholderError: UIColor {
        return UIColor.RGBColor("#ED6060", alpha: 0.9)
    }
    
    public class var bgPlaceholderLoading: UIColor {
        return UIColor.RGBColor("#F0F0F8", alpha: 0.9)
    }
}
