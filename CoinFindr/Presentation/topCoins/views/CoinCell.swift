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
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var rankTag: TagView!
    @IBOutlet weak var symbolTag: TagView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceUSDTitleLabel: UILabel!
    @IBOutlet weak var priceUSDLabel: UILabel!
    @IBOutlet weak var priceBTCTitleLabel: UILabel!
    @IBOutlet weak var priceBTCLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    private func setupUI() {
        
        // card
        cardView.layer.cornerRadius = 5.0
        cardView.layer.borderWidth = 1.0
        cardView.layer.borderColor = UIColor.RGBColor("#E4E4E4").cgColor
        // shadow
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.RGBColor("#E8DEFF").cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowRadius = 5
        cardView.layer.shadowOffset = CGSize(width: 2, height: 2)
        cardView.layer.shouldRasterize = true
        cardView.layer.rasterizationScale = UIScreen.main.scale
        
        // labels
        priceUSDTitleLabel.text = Strings.topCoinsCellPriceUsd()
        priceBTCTitleLabel.text = Strings.topCoinsCellPriceBtc()
    }
    
    func setup(coin: Coin) {

        rankTag.title = coin.rank
        symbolTag.title = coin.symbol
        
        nameLabel.text = coin.name
        priceUSDLabel.text = coin.priceUSD
        priceBTCLabel.text = coin.priceBTC
    }
}
