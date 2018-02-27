//
//  CoinsRepository.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol CoinsRepositoryProtocol {
    
    func getTopCoins() -> Single<[CoinAPI]>
}

class CoinsRepository: BaseRepository {
 
    internal let apiClient: CoinMarketCapAPIProtocol

    init(apiClient: CoinMarketCapAPIProtocol) {
        self.apiClient = apiClient
    }
}

extension CoinsRepository: CoinsRepositoryProtocol {
    
    func getTopCoins() -> Single<[CoinAPI]> {
        return apiClient.coins(limit: 10)
    }
}
