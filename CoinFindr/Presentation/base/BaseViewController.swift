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
    
    internal let basePresenter: BasePresenterProtocol
    internal var disposeBag: DisposeBag!
    
    private var backgroundImageView: UIImageView?
    private var placeholderView: UIView?
    
    init(presenter: BasePresenterProtocol, nibName: String?) {
        basePresenter = presenter
        super.init(nibName: nibName, bundle: nil)
    }
    
    init(presenter: BasePresenterProtocol) {
        basePresenter = presenter
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
        removeBackButtonTitle()
        bind()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var shouldAutorotate: Bool {
         return false
    }
    
    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
    
    internal func bind() {
        disposeBag = DisposeBag()
        
        basePresenter.viewState
            .bind {[weak self] (state) in
                guard let strongSelf = self else { return }
                switch state {
                    
                case .normal:
                    strongSelf.removePlaceholder()
                    
                case .failure(let viewModel):
                    strongSelf.showPlaceholderWith(viewModel: viewModel, type: .error)
                    
                case .loading(let viewModel):
                    strongSelf.showPlaceholderWith(viewModel: viewModel, type: .loading)
                    
                }
            }
            .disposed(by: disposeBag)
    }
}

extension BaseViewController {
    
    internal func addBackgroundImage(_ image: UIImage, withBlurEffect: Bool = false) {
        backgroundImageView?.removeFromSuperview()
        backgroundImageView = UIImageView(image: image)
        backgroundImageView?.contentMode = .scaleAspectFill
        view.addSubview(backgroundImageView!)
        view.sendSubview(toBack: backgroundImageView!)
        constrain(view, backgroundImageView!) { (container, image) in
            image.edges == container.edges
        }
        
        if withBlurEffect {
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark) //extraLight, light, dark
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = backgroundImageView!.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            backgroundImageView!.addSubview(blurEffectView)
        }
    }
}

extension BaseViewController {
    
    private func removeBackButtonTitle() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    internal func addBackButtonModalFlow(onClose: @escaping (() -> Void)) {
        let backButton = UIBarButtonItem(barButtonSystemItem: .stop, target: nil, action: nil)
        _ = backButton.rx.tap
            .takeUntil(rx.deallocated)
            .bind { onClose() }
        navigationItem.leftBarButtonItem = backButton
    }
}

extension BaseViewController {
    
    private func removePlaceholder() {
        placeholderView?.removeFromSuperview()
    }
    
    private func showPlaceholderWith(viewModel: PlaceholderViewModel, type: PlaceholderType) {
        view.endEditing(true)
        
        switch type {
        case .loading:
            showLoading(viewModel: viewModel)
            
        case .error:
            showError(viewModel: viewModel)
        }
    }
    
    private func showLoading(viewModel: PlaceholderViewModel) {
        removePlaceholder()
        
        let loadingView = LoadingView()
        loadingView.presentOn(parentView: self.view, with: viewModel)
        self.placeholderView = loadingView
    }
    
    private func showError(viewModel: PlaceholderViewModel) {
        removePlaceholder()
        
        let errorView = ErrorView()
        errorView.presentOn(parentView: self.view, with: viewModel)
        self.placeholderView = errorView
    }
}

extension BaseViewController {
    
    internal func setOrientation(_ orientation: UIInterfaceOrientation) {
        UIDevice.current.setValue(orientation.rawValue, forKey: "orientation")
    }
}
