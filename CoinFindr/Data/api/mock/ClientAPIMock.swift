//
//  ClientAPIMock.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

class CoinMarketCapAPIClientMock: CoinMarketCapAPIProtocol {
    
    func tickers(limit: Int) {
        print("CoinMarketCapAPIClientMock -> tickers")
        // do nothing...
    }
}
