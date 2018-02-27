//
//  CoinsRouter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxCocoa

protocol CoinsRouterProtocol: class {

}

class CoinsRouter: BaseRouter {
    
    private let _navigationController: UINavigationController
    private let _viewController: CoinsViewController
    private var _presenter: CoinsPresenterProtocol
    
    var viewController: UIViewController {
        return _navigationController
    }
    
    override init() {
        
        let interactor = CoinsInteractor(repository: CoinsRepository(apiClient: CoinMarketCapAPI()))
        _presenter = CoinsPresenter(interactor: interactor)
        _viewController = CoinsViewController(presenter: _presenter)
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
                    strongSelf.presentedWireFrame = nil
                }
            })
    }
}

extension CoinsRouter: CoinsRouterProtocol {
    
}
