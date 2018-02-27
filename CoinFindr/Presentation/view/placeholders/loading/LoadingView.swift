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
    
    init(viewModel: PlaceholderViewModel) {
        super.init(frame: .zero)

        self.backgroundColor = UIColor.bgPlaceholderLoading
        self.titleLabel.text = viewModel.text
        self.titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        self.titleLabel.textColor = UIColor.customBlue
        
//        self.alpha = 0.0
//        self.loadingImageCenterYConstraint.constant = -self.frame.size.height
//        self.loadingImage.alpha = 0.0
//        self.titleLabel.alpha = 0.0
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented. Use `ini(viewModel:) instead`")
    }

    // ************************************************
    // MARK: - @IBOutlets
    // ************************************************
    
    @IBOutlet weak var loadingImageCenterYConstraint: NSLayoutConstraint!
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
        parent.layoutIfNeeded()

        DispatchQueue.main.async {
            [weak self] in
            guard let strongSelf = self else { return }

            strongSelf.animate()
            
            UIView.animate(
                withDuration: 0.25,
                animations: {
                    [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.alpha = 1.0
                },
                completion: {
                    [weak self] (result) in
                    guard let strongSelf = self else { return }
                    
                    strongSelf.loadingImageCenterYConstraint.constant = -15
                    UIView.animate(
                        withDuration: 0.25,
                        animations: {
                            
                            strongSelf.loadingImage.alpha = 1.0
                            strongSelf.titleLabel.alpha = 1.0
                            
                            strongSelf.layoutIfNeeded()
                        }
                    )
                }
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
