//
//  CoinDetailsRouter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxCocoa

protocol CoinDetailsRouterProtocol: class {

}

class CoinDetailsRouter: BaseRouter {
    
    private let _viewController: CoinDetailsViewController
    private var _presenter: CoinDetailsPresenterProtocol
    
    init(coin: Coin, callback: BaseRouter) {
        
        let interactor = CoinDetailsInteractor(coin: coin)
        _presenter = CoinDetailsPresenter(interactor: interactor)
        _viewController = CoinDetailsViewController(presenter: _presenter)
        
        super.init()
        
        _presenter.router = self
        self.callback = callback
    }
    
    func present(on viewController: UIViewController) {
        
        viewController.present(_viewController, animated: true)
    }
}

extension CoinDetailsRouter: CoinDetailsRouterProtocol {
    
}
