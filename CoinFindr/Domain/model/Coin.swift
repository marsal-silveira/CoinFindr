//
//  Coin.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

struct Coin {
    
    var id: String
    var name: String
    var symbol: String
    var rank: String
    var priceUSD: String
    var priceBTC: String
}

extension Coin {
    
    static func map(coinAPI: CoinAPI) -> Coin? {
        
        func currencyFormat(value: String) -> String {
            
            guard let valueDouble = Double(value) else { return "##" }

            let formatter = NumberFormatter()
            formatter.locale = Locale(identifier: "en_US") // always USA English...
            formatter.numberStyle = .currency
            return formatter.string(from: valueDouble as NSNumber) ?? "##"
        }
        
        guard let id = coinAPI.id,
              let name = coinAPI.name,
              let symbol = coinAPI.symbol,
              let rank = coinAPI.rank,
              let priceUSD = coinAPI.priceUSD,
              let priceBTC = coinAPI.priceBTC else {
            return nil
        }
        
        return Coin(id: id, name: name, symbol: symbol, rank: "#\(rank)", priceUSD: currencyFormat(value: priceUSD), priceBTC: priceBTC)
    }
    
    static func mapArray(coinsAPI: [CoinAPI]) -> [Coin] {
        
        return coinsAPI
            .map { map(coinAPI: $0) }
            .filter { $0 != nil }
            .map { $0! }
    }
}
