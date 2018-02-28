//
//  BaseViewController.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import Cartography
import RxSwift

class BaseViewController: UIViewController {
    
    // ************************************************
    // MARK: Properties
    // ************************************************
    
    private let _basePresenter: BasePresenterProtocol
    internal var basePresenter: BasePresenterProtocol { return _basePresenter }
    
    private var _disposeBag: DisposeBag = DisposeBag()
    internal var disposeBag: DisposeBag { return _disposeBag }
    
    private var _placeholder: Placeholder?
    
    // ************************************************
    // MARK: Init | Lifecycle
    // ************************************************
    
    init(presenter: BasePresenterProtocol, nibName: String?) {
        _basePresenter = presenter
        super.init(nibName: nibName, bundle: nil)
    }
    
    init(presenter: BasePresenterProtocol) {
        _basePresenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        self.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupOnLoad()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
    
    // ************************************************
    // MARK: Setup
    // ************************************************
    
    private func setupOnLoad() {
    
        self.bind()
    }
    
    internal func bind() {

        _basePresenter.viewState
            .bind {[weak self] (state) in
                guard let strongSelf = self else { return }
                switch state {
                    
                case .normal:
                    strongSelf.dismissPlaceholder()
                    
                case .loading(let viewModel):
                    strongSelf.presentPlaceholder(type: .loading(viewModel))
                    
                case .error(let viewModel):
                    strongSelf.presentPlaceholder(type: .error(viewModel))
                }
            }
            .disposed(by: disposeBag)
    }
    
    // ************************************************
    // MARK: Placeholders
    // ************************************************

    private func presentPlaceholder(type: PlaceholderType) {
        view.endEditing(true)
        
        switch type {
        case .loading(let viewModel):
            self.showLoading(viewModel: viewModel)
            
        case .error(let viewModel):
            self.showError(viewModel: viewModel)
        }
    }
    
    private func dismissPlaceholder() {
        _placeholder?.dismiss()
        _placeholder = nil
    }

    private func showLoading(viewModel: LoadingViewModel) {
        self.dismissPlaceholder()
        
        let loadingView = LoadingView(viewModel: viewModel)
        loadingView.present(on: self.view)
        _placeholder = loadingView
    }
    
    private func showError(viewModel: ErrorViewModel) {
        dismissPlaceholder()
        
        let errorView = ErrorView(viewModel: viewModel)
        errorView.present(on: self.view)
        _placeholder = errorView
    }
}
