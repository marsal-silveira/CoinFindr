//
//  StringFormatter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation

enum StringFormatter {
    
    static func number(value: String) -> String {
        
        guard let valueDouble = Double(value) else { return "" }
        
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter.string(from: valueDouble as NSNumber) ?? ""
    }
    
    static func currency(value: String) -> String {
        
        guard let valueDouble = Double(value) else { return "" }
        
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        return formatter.string(from: valueDouble as NSNumber) ?? ""
    }
    
    static func date(value: String) -> String {
        
        guard let timeInterval = Double(value) else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(identifier: TimeZone.autoupdatingCurrent.identifier)
        dateFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return dateFormatter.string(from: Date(timeIntervalSince1970: timeInterval))
    }
}
