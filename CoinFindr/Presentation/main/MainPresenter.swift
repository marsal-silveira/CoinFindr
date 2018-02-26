//
//  MainPresenter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxSwift

protocol MainInteractorProtocol: class {
    
}

class MainInteractor: MainInteractorProtocol {
    
}

protocol MainPresenterProtocol: BasePresenterProtocol {

    var router: MainRouterProtocol? { get set }
}

class MainPresenter: BasePresenter {
    
    private let _interactor: MainInteractorProtocol
    private let _disposeBag: DisposeBag
    
    private weak var _router: MainRouterProtocol?
    public var router: MainRouterProtocol? {
        get { return _router }
        set { _router = newValue }
    }
    
    init(interactor: MainInteractorProtocol) {
    
        _interactor = interactor
        _disposeBag = DisposeBag()
        
        super.init()
        bind()
    }
    
    private func bind() {
        // to implements
    }
}

extension MainPresenter: MainPresenterProtocol {
    
}
