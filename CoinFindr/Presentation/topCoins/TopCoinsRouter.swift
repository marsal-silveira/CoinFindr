//
//  TopCoinsRouter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxCocoa

protocol TopCoinsRouterProtocol: class {
    func showCoinDetails(_ coin: Coin)
}

class TopCoinsRouter: BaseRouter {
    
    private let _navigationController: BaseNavigationController
    private let _viewController: TopCoinsViewController
    private var _presenter: TopCoinsPresenterProtocol
    
    var viewController: UIViewController {
        return _navigationController
    }
    
    override init() {
        
        let interactor = TopCoinsInteractor(repository: RepositoryPool.shared.coinRepository)
        _presenter = TopCoinsPresenter(interactor: interactor)
        _viewController = TopCoinsViewController(presenter: _presenter)
        _navigationController = BaseNavigationController(rootViewController: _viewController)
        
        super.init()
        
        _presenter.router = self
        self.bind()
    }
    
    private func bind() {
        _ = _navigationController.rx
            .didShow
            .takeUntil(rx.deallocated)
            .subscribe(onNext: { [weak self] (viewController, _) in
                guard let strongSelf = self else { return }
                
                if strongSelf._viewController === viewController {
                    strongSelf.presentedRouter = nil
                }
            })
    }
}

extension TopCoinsRouter: TopCoinsRouterProtocol {

    func showCoinDetails(_ coin: Coin) {
        
        let detailsRouter = CoinDetailsRouter(coin: coin, callback: self)
        detailsRouter.present(on: _viewController)
        presentedRouter = detailsRouter
    }
}
