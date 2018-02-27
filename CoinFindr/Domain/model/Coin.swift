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
}

extension Coin {
    
    static func map(coinAPI: CoinAPI) -> Coin? {
        
        guard let id = coinAPI.id,
              let name = coinAPI.name,
              let symbol = coinAPI.symbol,
              let rank = coinAPI.rank else {
            return nil
        }
        return Coin(id: id, name: name, symbol: symbol, rank: "#\(rank)")
    }
    
    static func mapArray(coinsAPI: [CoinAPI]) -> [Coin] {
        
        return coinsAPI
            .map { map(coinAPI: $0) }
            .filter { $0 != nil }
            .map { $0! }
    }
}
