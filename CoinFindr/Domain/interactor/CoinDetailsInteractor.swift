//
//  CoinDetailsInteractor.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import RxSwift

protocol CoinDetailsInteractorProtocol {
    var coin: Coin { get }
}

class CoinDetailsInteractor: BaseInteractor {
    
    private let _coin: Coin
    
    init(coin: Coin) {
        
        _coin = coin
        super.init()
    }
}

extension CoinDetailsInteractor: CoinDetailsInteractorProtocol {
    
    var coin: Coin {
        return _coin
    }
}
