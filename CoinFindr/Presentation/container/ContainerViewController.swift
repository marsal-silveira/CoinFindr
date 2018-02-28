//
//  ContainerViewController.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import Cartography

class ContainerViewController: BaseViewController {
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let currentViewController = currentViewController else {
            return .lightContent
        }
        return currentViewController.preferredStatusBarStyle
    }

    private(set) var currentViewController: UIViewController? {
        
        didSet {
            if let currentViewController = currentViewController {
                
                currentViewController.willMove(toParentViewController: self)
                addChildViewController(currentViewController)
                currentViewController.didMove(toParentViewController: self)
                
                if let oldViewController = oldValue {
                    view.insertSubview(currentViewController.view, belowSubview: oldViewController.view)
                } else {
                    view.addSubview(currentViewController.view)
                }
                
                constrain(currentViewController.view, view, block: { (childView, parentView) in
                    childView.edges == parentView.edges
                })
                
                self.setNeedsStatusBarAppearanceUpdate()
            }
            
            if let oldViewController = oldValue {
                
                self.applyScreenTransition(newViewController: currentViewController, oldViewController: oldViewController)
            }
        }
    }
    
    private func applyScreenTransition(newViewController: UIViewController?, oldViewController: UIViewController) {
        
        if let newViewController = newViewController {
            
            newViewController.view.transform = CGAffineTransform(translationX: 0, y: -(self.view.frame.size.height))
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: [], animations: {
                newViewController.view.transform = CGAffineTransform.identity
                oldViewController.view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
            }, completion: { (finished) in
                oldViewController.removeDefinitely()
            })
            
        } else {
            oldViewController.removeDefinitely()
        }
    }
}

extension ContainerViewController {
    
    func setCurrentViewController(_ viewController: UIViewController) {
        currentViewController = viewController
    }
}
