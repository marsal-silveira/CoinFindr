//
//  CoinCell.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit

class CoinCell: UITableViewCell {
    
    @IBOutlet weak var viewIdentifier: UIView!
    @IBOutlet weak var lblIdentifier: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        viewIdentifier.layer.cornerRadius = 15.0
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        lblIdentifier.text = nil
        lblName.text = nil
    }
    
    public func setup(coin: Coin) {
        
        lblIdentifier.text = coin.symbol
        lblName.text = coin.name
    }
}
