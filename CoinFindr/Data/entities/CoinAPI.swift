//
//  CoinAPI.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

//import Foundation
import ObjectMapper

class CoinAPI: Mappable {
    
    var id: String?
    var name: String?
    var symbol: String?
    var rank: String?
    var priceUSD: String?
    var priceBTC: String?
    
    // details
    var volumeUSD_24h: String?
    var marketCapUSD: String?
    var availableSupply: String?
    var totalSupply: String?
    var maxSupply: String?
    var percentChange_1h: String?
    var percentChange_24h: String?
    var percentChange_7d: String?
    var lastUpdated: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        symbol <- map["symbol"]
        rank <- map["rank"]
        priceUSD <- map["price_usd"]
        priceBTC <- map["price_btc"]
        
        // details
        volumeUSD_24h <- map["24h_volume_usd"]
        marketCapUSD <- map["market_cap_usd"]
        availableSupply <- map["available_supply"]
        totalSupply <- map["total_supply"]
        maxSupply <- map["max_supply"]
        percentChange_1h <- map["percent_change_1h"]
        percentChange_24h <- map["percent_change_24h"]
        percentChange_7d <- map["percent_change_7d"]
        lastUpdated <- map["last_updated"]
    }
}
