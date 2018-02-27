//
//  CoinsPresenter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxSwift

protocol CoinsPresenterProtocol: BasePresenterProtocol {

    var router: CoinsRouterProtocol? { get set }
    var coins: Observable<[Coin]> { get }
    
    func getCoins()
}

class CoinsPresenter: BasePresenter {
    
    private let _interactor: CoinsInteractorProtocol
    private let _disposeBag = DisposeBag()
    
    private var _coinsVariable = Variable<[Coin]>([])

    private weak var _router: CoinsRouterProtocol?
    public var router: CoinsRouterProtocol? {
        get { return _router }
        set { _router = newValue }
    }
    
    init(interactor: CoinsInteractorProtocol) {
    
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
                    strongSelf.viewStateVariable.value = .loading(PlaceholderViewModel(text: R.string.localizable.placeholderLoading()))

                case .success(let topCoins):
                    strongSelf.viewStateVariable.value = .normal
                    strongSelf._coinsVariable.value = topCoins
                    
                case .failure(let error):
                    let placeholderViewModel = PlaceholderViewModel(text: error.localizedDescription, action: nil)
                    strongSelf.viewStateVariable.value = .failure(placeholderViewModel)
                    
                default:
                    break
                }
            }
            .disposed(by: _disposeBag)
    }
}

extension CoinsPresenter: CoinsPresenterProtocol {
    
    var coins: Observable<[Coin]> {
        return _coinsVariable.asObservable()
    }
    
    func getCoins() {
        _interactor.getTopCoins()
    }
    
//    func viewDidAppear() {
//
//        // TODO: fetch data from server...
////        let clientApi = CoinsMarketCapAPIClient()
//        let clientApi = CoinMarketCapAPIClientMock()
//        print(clientApi.coins(limit: 10))
//    }
}
