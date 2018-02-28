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
    }
}
