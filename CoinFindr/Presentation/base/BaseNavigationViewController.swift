//
//  BaseNavigationViewController.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.replaceBackButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func transparentNavigation() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        view.backgroundColor = .clear
    }
    
    private func replaceBackButton() {
        navigationBar.tintColor = .white
//        navigationBar.backIndicatorImage = #imageLiteral(resourceName: "ic_nav_back")
//        navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "ic_nav_back")
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
}
