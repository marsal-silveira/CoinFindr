//
//  CoinsInteractor.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import RxSwift

protocol CoinsInteractorProtocol {
    
    var topCoins: Observable<RequestResponse<[Coin]>> { get }
    func getTopCoins()
}

class CoinsInteractor: BaseInteractor {
    
    private let _repository: CoinsRepositoryProtocol
    private var _disposeBag = DisposeBag()
    
    private let _topCoinsVariable = Variable<RequestResponse<[Coin]>>(.new)
    
    init(repository: CoinsRepositoryProtocol) {
        
        _repository = repository
        super.init()
    }
}

extension CoinsInteractor: CoinsInteractorProtocol {
    
    var topCoins: Observable<RequestResponse<[Coin]>> {
        return _topCoinsVariable.asObservable()
    }
    
    func getTopCoins() {
        
        _topCoinsVariable.value = .loading
        
        _repository.getTopCoins()
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
