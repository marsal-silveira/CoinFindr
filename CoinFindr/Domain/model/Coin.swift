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
    
    // details
    var volumeUSD_24h: String
    var marketCapUSD: String
    var availableSupply: String
    var totalSupply: String
    var maxSupply: String
    var percentChange_1h: String
    var percentChange_24h: String
    var percentChange_7d: String
    var lastUpdated: String
}

extension Coin {
    
    static func map(coinAPI: CoinAPI) -> Coin? {
                
        guard let id = coinAPI.id,
              let name = coinAPI.name,
              let symbol = coinAPI.symbol,
              let rank = coinAPI.rank,
              let priceUSD = coinAPI.priceUSD,
              let priceBTC = coinAPI.priceBTC,
              // details
              let volumeUSD_24h = coinAPI.volumeUSD_24h,
              let marketCapUSD = coinAPI.marketCapUSD,
              let availableSupply = coinAPI.availableSupply,
              let totalSupply = coinAPI.totalSupply,
              let maxSupply = coinAPI.maxSupply,
              let percentChange_1h = coinAPI.percentChange_1h,
              let percentChange_24h = coinAPI.percentChange_24h,
              let percentChange_7d = coinAPI.percentChange_7d,
              let lastUpdated = coinAPI.lastUpdated else {

            return nil
        }
        
        return Coin(
            id: id,
            name: name,
            symbol: symbol,
            rank: "#\(rank)",
            priceUSD: StringFormatter.currency(value: priceUSD),
            priceBTC: priceBTC,
            // details
            volumeUSD_24h: StringFormatter.currency(value: volumeUSD_24h),
            marketCapUSD: StringFormatter.currency(value: marketCapUSD),
            availableSupply: StringFormatter.number(value: availableSupply),
            totalSupply: StringFormatter.number(value: totalSupply),
            maxSupply: StringFormatter.number(value: maxSupply),
            percentChange_1h: "\(percentChange_1h)%",
            percentChange_24h: "\(percentChange_24h)%",
            percentChange_7d: "\(percentChange_7d)%",
            lastUpdated: StringFormatter.date(value: lastUpdated)
        )
    }
    
    static func mapArray(coinsAPI: [CoinAPI]) -> [Coin] {
        
        return coinsAPI
            .map { map(coinAPI: $0) }
            .filter { $0 != nil }
            .map { $0! }
    }
}
