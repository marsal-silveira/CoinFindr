//
//  PresentationExtensions.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

// MARK: - UIViewController
extension UIViewController {

    func removeDefinitely() {
        
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}
