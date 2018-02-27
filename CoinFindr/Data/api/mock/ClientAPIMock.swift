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
    
    func coins(limit: Int) -> Single<[CoinAPI]> {
        return Single.error(APIError.error(description: "¯\\_(ツ)_/¯\nNot implemented"))
    }
}
