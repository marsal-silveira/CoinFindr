//
//  TopCoinsInteractor.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import RxSwift

protocol TopCoinsInteractorProtocol {
    
    var coins: Observable<RequestResponse<[Coin]>> { get }
    
    func getCoins()
    func startPooling()
    func stopPooling()
}

class TopCoinsInteractor: BaseInteractor {
    
    private let _repository: CoinRepositoryProtocol
    private var _disposeBag = DisposeBag()
    
    // pooling timer... 5-5 minutes this will start a new search from top coins...
    private var _timer: Timer?
    
    init(repository: CoinRepositoryProtocol) {
        
        _repository = repository
        super.init()
    }
}

extension TopCoinsInteractor: TopCoinsInteractorProtocol {

    var coins: Observable<RequestResponse<[Coin]>> {
        return _repository.topCoins
    }

    func getCoins() {
        _repository.getTopCoins()
    }

    func startPooling() {

        guard _timer == nil else { return }

        _timer = Timer.scheduledTimer(
            withTimeInterval: 60.0 * 5, // 5 min
            repeats: true,
            block: {
                [weak self] (timer) in
                guard let strongSelf = self else { return }

                strongSelf._repository.getTopCoins()
            }
        )
    }

    func stopPooling() {

        guard let timer = _timer else { return }

        timer.invalidate()
        _timer = nil
    }
}
