//
//  PresentationExtensions.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit

// ************************************************
// MARK: - UIViewController
// ************************************************

extension UIViewController {

    func removeDefinitely() {
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
}

// ************************************************
// MARK: - UITableViewCell
// ************************************************

extension UITableViewCell {
    
    public static var identifier: String {
        return String(describing: self)
    }
    
    public static var nibName: String {
        return self.identifier
    }
}

// ************************************************
// MARK: - UITableView
// ************************************************

extension UITableView {
    
    public func register<CellType: UITableViewCell>(_: CellType.Type) {
        register(UINib(nibName: CellType.nibName, bundle: nil), forCellReuseIdentifier: CellType.identifier)
    }
    
    public func dequeueReusableCell<CellType: UITableViewCell>(forIndexPath indexPath: IndexPath) -> CellType {
        guard let cell = dequeueReusableCell(withIdentifier: CellType.identifier, for: indexPath) as? CellType else {
            fatalError("Could not dequeue cell with identifier: \(CellType.identifier)")
        }
        return cell
    }
}
