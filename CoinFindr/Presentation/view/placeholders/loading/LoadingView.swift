//
//  LoadingView.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class LoadingView: NibDesignable {

    // ************************************************
    // MARK: - Init
    // ************************************************
    
    init(viewModel: LoadingViewModel) {
        super.init(frame: .zero)

        self.backgroundColor = UIColor.bgPlaceholderLoading
        self.titleLabel.text = viewModel.text
        self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.titleLabel.textColor = UIColor.customBlue
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use `ini(viewModel:) instead`")
    }

    // ************************************************
    // MARK: - @IBOutlets
    // ************************************************
    
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //*************************************************
    // MARK: - Animate
    //*************************************************
    
    fileprivate func animate() {
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = -Double.pi*2
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = .infinity
        loadingImage.layer.add(rotationAnimation, forKey: nil)
    }
}

//*************************************************
// MARK: - Placeholder
//*************************************************

extension LoadingView: Placeholder {

    func present(on parent: UIView) {
        
        parent.addSubview(self)
        constrain(self, parent) { (view, container) in
            view.leading == container.leading
            view.top == container.top
            view.trailing == container.trailing
            view.bottom == container.bottom
        }

        DispatchQueue.main.async {
            [weak self] in
            self?.animate()
        }
    }
    
    func dismiss() {
        
        DispatchQueue.main.async {
            [weak self] in
            self?.removeFromSuperview()
        }
    }
}
