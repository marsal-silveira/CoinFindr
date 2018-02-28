//
//  CoinDetailsPresenter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxSwift

protocol CoinDetailsPresenterProtocol: BasePresenterProtocol {

    var router: CoinDetailsRouterProtocol? { get set }
    var coin: Coin { get }
}

class CoinDetailsPresenter: BasePresenter {

    private let _interactor: CoinDetailsInteractorProtocol

    private weak var _router: CoinDetailsRouterProtocol?
    public var router: CoinDetailsRouterProtocol? {
        get { return _router }
        set { _router = newValue }
    }
    
    init(interactor: CoinDetailsInteractorProtocol) {
    
        _interactor = interactor
        super.init()
    }
}

extension CoinDetailsPresenter: CoinDetailsPresenterProtocol {
    
    var coin: Coin {
        return _interactor.coin
    }
}
