//
//  BasePresenter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxSwift

enum ViewState {
    
    case normal
    case loading(PlaceholderViewModel)
    case failure(PlaceholderViewModel)
}

protocol BasePresenterProtocol {
    
    var viewState: Observable<ViewState> { get }
}

class BasePresenter: NSObject {
    
    internal let viewStateVariable = Variable<ViewState>(.normal)

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BasePresenter: BasePresenterProtocol {
    
    var viewState: Observable<ViewState> {
        return viewStateVariable.asObservable()
    }
}
