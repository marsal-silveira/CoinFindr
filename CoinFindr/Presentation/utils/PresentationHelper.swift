//
//  PresentationHelper.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

class PresentationHelper {

    static func topViewController() -> UIViewController? {
        
        guard var topController = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        
        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }
        return topController
    }

    static func romePresentedModalsViewControllers() {
        
        if let topController = topViewController() {
            
            if !topController.isKind(of: ContainerViewController.self) {
                topController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
