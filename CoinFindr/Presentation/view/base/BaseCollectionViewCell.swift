//
//  BaseCollectionViewCell.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import RxSwift

class BaseCollectionViewCell: UICollectionViewCell {
    
    internal var viewModelDisposeBag: DisposeBag!
    
    static var nibName: String {
        return String(describing: self)
    }
    
    internal static var staticCell: BaseCollectionViewCell {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first! as! BaseCollectionViewCell
    }
}
