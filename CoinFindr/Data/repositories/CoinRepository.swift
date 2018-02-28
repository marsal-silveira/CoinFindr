//
//  CoinRepository.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

protocol CoinRepositoryProtocol {
    
    var topCoins: Observable<RequestResponse<[Coin]>> { get }
    func getTopCoins()
}

class CoinRepository: BaseRepository {
    
    private let _apiClient: CoinMarketCapAPIProtocol
    private let _topCoinsVariable = Variable<RequestResponse<[Coin]>>(.new)
    private let _disposeBag = DisposeBag()

    init(apiClient: CoinMarketCapAPIProtocol) {
        _apiClient = apiClient
    }
}

extension CoinRepository: CoinRepositoryProtocol {

    var topCoins: Observable<RequestResponse<[Coin]>> {
        return _topCoinsVariable.asObservable()
    }

    func getTopCoins() {

        _topCoinsVariable.value = .loading
        
        _apiClient.coins(limit: 10)
            .subscribe { [weak self] (eventRx) in
                guard let strongSelf = self else { return }
                
                let event = transformEvent(event: eventRx)
                switch event {
                    
                case .success(let coinsAPI):
                    let coins = Coin.mapArray(coinsAPI: coinsAPI)
                    strongSelf._topCoinsVariable.value = .success(coins)
                    
                case .error(let error):
                    strongSelf._topCoinsVariable.value = .failure(error)
                }
            }
            .disposed(by: _disposeBag)
    }
}
