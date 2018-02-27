//
//  TopCoinsPresenter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxSwift

protocol TopCoinsPresenterProtocol: BasePresenterProtocol {

    var router: TopCoinsRouterProtocol? { get set }
    var coins: Observable<[Coin]> { get }
    
    func getCoins()
}

class TopCoinsPresenter: BasePresenter {
    
    private let _interactor: TopCoinsInteractorProtocol
    private let _disposeBag = DisposeBag()
    
    private var _coinsVariable = Variable<[Coin]>([])

    private weak var _router: TopCoinsRouterProtocol?
    public var router: TopCoinsRouterProtocol? {
        get { return _router }
        set { _router = newValue }
    }
    
    init(interactor: TopCoinsInteractorProtocol) {
    
        _interactor = interactor
        
        super.init()
        bind()
    }
    
    private func bind() {
        
        _interactor.topCoins
            .bind {[weak self] (response) in
                guard let strongSelf = self else { return }
                
                switch response {
                    
                case .loading:
                    strongSelf.viewStateVariable.value = .loading(PlaceholderViewModel(text: Strings.placeholderLoading()))

                case .success(let coins):
                    strongSelf.viewStateVariable.value = .normal
                    strongSelf._coinsVariable.value = coins
//                    let placeholderViewModel = PlaceholderViewModel(text: Strings.errorDefault(), details: "coins -> \(coins.count)")
//                    strongSelf.viewStateVariable.value = .failure(placeholderViewModel)

                case .failure(let error):
                    let placeholderViewModel = PlaceholderViewModel(text: Strings.errorDefault(), details: error.localizedDescription)
                    strongSelf.viewStateVariable.value = .failure(placeholderViewModel)
                    
                default:
                    break
                }
            }
            .disposed(by: _disposeBag)
    }
}

extension TopCoinsPresenter: TopCoinsPresenterProtocol {
    
    var coins: Observable<[Coin]> {
        return _coinsVariable.asObservable()
    }
    
    func getCoins() {
        _interactor.getTopCoins()
    }
}
