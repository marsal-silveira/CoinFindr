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
    
    override func loadView() {
        super.loadView()

        view.backgroundColor = .white
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
                    
                case .failure(let viewModel):
                    strongSelf.presentPlaceholder(with: viewModel, type: .error)
                    
                case .loading(let viewModel):
                    strongSelf.presentPlaceholder(with: viewModel, type: .loading)
                }
            }
            .disposed(by: disposeBag)
    }
    
    // ************************************************
    // MARK: Placeholders
    // ************************************************

    private func presentPlaceholder(with viewModel: PlaceholderViewModel, type: PlaceholderType) {
        view.endEditing(true)
        
        switch type {
        case .loading:
            self.showLoading(viewModel: viewModel)
            
        case .error:
            self.showError(viewModel: viewModel)
        }
    }
    
    private func dismissPlaceholder() {
        _placeholder?.dismiss()
        _placeholder = nil
    }

    private func showLoading(viewModel: PlaceholderViewModel) {
        self.dismissPlaceholder()
        
        let loadingView = LoadingView(viewModel: viewModel)
        loadingView.present(on: self.view)
        _placeholder = loadingView
    }
    
    private func showError(viewModel: PlaceholderViewModel) {
        dismissPlaceholder()
        
        let errorView = ErrorView(viewModel: viewModel)
        errorView.present(on: self.view)
        _placeholder = errorView
    }
}
