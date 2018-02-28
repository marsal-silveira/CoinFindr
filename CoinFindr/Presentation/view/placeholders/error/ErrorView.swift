//
//  ErrorView.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit
import Cartography
import RxSwift

class ErrorView: NibDesignable {
    
    // ************************************************
    // MARK: - Init | Lifecycle
    // ************************************************
    
    init(viewModel: ErrorViewModel) {
        super.init(frame: .zero)
        
        self.backgroundColor = UIColor.bgPlaceholderError
        self.titleLabel.text = viewModel.text
        self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        self.titleLabel.textColor = UIColor.white
        self.detailsLabel.text = viewModel.details
        self.detailsLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        self.detailsLabel.textColor = UIColor.white

        self.alpha = 0.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use `ini(viewModel:) instead`")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupOnLoad()
    }
    
    // ************************************************
    // MARK: - Properties
    // ************************************************
    
    private var _disposeBag = DisposeBag()
    
    // ************************************************
    // MARK: - @IBOutlets
    // ************************************************
    
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    //*************************************************
    // MARK: - Setup
    //*************************************************
    
    private func setupOnLoad() {
        
        self.setupLabels()
        self.setupCloseButton()
    }
    
    private func setupLabels() {
        
        self.titleLabel.adjustsFontSizeToFitWidth = true
        self.titleLabel.adjustsFontForContentSizeCategory = true
        
        self.detailsLabel.adjustsFontSizeToFitWidth = true
        self.detailsLabel.adjustsFontForContentSizeCategory = true
    }
    
    private func setupCloseButton() {
        
        self.closeButton.rx.tap
            .bind {
                [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.dismiss()
            }
            .disposed(by: _disposeBag)
    }
}

//*************************************************
// MARK: - Placeholder
//*************************************************

extension ErrorView: Placeholder {
    
    func present(on parent: UIView) {
        
        parent.addSubview(self)
        constrain(self, parent) { (view, container) in
            view.leading == container.leading
            view.top == container.top
            view.trailing == container.trailing
            view.bottom == container.bottom
        }
        
        DispatchQueue.main.async {
            
            UIView.animate(
                withDuration: 0.25,
                animations: {
                    [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.alpha = 1.0
                },
                completion: nil
            )
        }
    }
    
    func dismiss() {
        
        DispatchQueue.main.async {
            [weak self] in
            self?.removeFromSuperview()
        }
    }
}
