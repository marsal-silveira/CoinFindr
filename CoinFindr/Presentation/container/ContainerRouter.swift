//
//  ContainerRouter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

enum ContentScreen {
    case topCoins
}

protocol ContainerRouterProtocol: class {
    func updateCurrentScreen(_ screen: ContentScreen)
}

class ContainerRouter: BaseRouter {
    
    private let _viewController: ContainerViewController
    private let _presenter: ContainerPresenterProtocol
    private var _childWireFrame: BaseRouter?
    
    private var _currentScreen: ContentScreen?
    
    override init() {
        
        _presenter = ContainerPresenter()
        _viewController = ContainerViewController(presenter: _presenter)

        super.init()
    }
    
    func presentOn(window: UIWindow) {
        
        window.rootViewController = _viewController
        window.makeKeyAndVisible()
        
        // fixed because we have only one possible screen... if we have a session we can change the VC in show automatically using this behavior
        self.updateCurrentScreen(.topCoins)
    }
}

extension ContainerRouter: ContainerRouterProtocol {
    
    func updateCurrentScreen(_ screen: ContentScreen) {
        
        guard screen != _currentScreen else { return }
        switch screen {

        case .topCoins:
            let topCoinsRouter = TopCoinsRouter()
            _viewController.setCurrentViewController(topCoinsRouter.viewController)
            _childWireFrame = topCoinsRouter
        }
        
        _currentScreen = screen
    }
}
