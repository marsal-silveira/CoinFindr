//
//  MainRouter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxCocoa

protocol MainRouterProtocol: class {

    func viewDidAppear()
}

class MainRouter: BaseRouter {
    
    private let _viewController: MainViewController
    public var viewController: MainViewController { return _viewController }
    
    private var _presenter: MainPresenterProtocol
    
    override init() {
        
//        let interactor = MainInteractor(repository: Repository(apiClient: APIClient()))
        let interactor = MainInteractor()
        _presenter = MainPresenter(interactor: interactor)
        _viewController = MainViewController(presenter: _presenter)
        
        super.init()
        
        _presenter.router = self
    }
}

extension MainRouter: MainRouterProtocol {
    
    func viewDidAppear() {
     
        // TODO: fetch data from server...
    }
}
