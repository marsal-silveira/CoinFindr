//
//  CoinDetailsViewController.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import Cartography
import RxSwift
import RxCocoa

class CoinDetailsViewController: BaseViewController {

    // ************************************************
    // MARK: Properties
    // ************************************************

    private var _presenter: CoinDetailsPresenterProtocol {
        return basePresenter as! CoinDetailsPresenterProtocol
    }

    private let _disposeBag = DisposeBag()

    //*************************************************
    // MARK: - @IBOutlets
    //*************************************************

    @IBOutlet weak var containerView: UIView!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceUSDLabel: UILabel!
    @IBOutlet weak var priceBTCLabel: UILabel!
    @IBOutlet weak var volumeUSD_24hLabel: UILabel!
    @IBOutlet weak var marketCapUSDLabel: UILabel!
    @IBOutlet weak var availableSupplyLabel: UILabel!
    @IBOutlet weak var totalSupplyLabel: UILabel!
    @IBOutlet weak var maxSupplyLabel: UILabel!
    @IBOutlet weak var percentChange_1hLabel: UILabel!
    @IBOutlet weak var percentChange_24hLabel: UILabel!
    @IBOutlet weak var percentChange_7dLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!

    //*************************************************
    // MARK: - @IBActions
    //*************************************************

    @IBAction func onButtonClick(_ sender: UIButton) {
        self.close()
    }
    
    // ***************************************************
    // MARK: - Factory | Init
    // ***************************************************

    override init(presenter: BasePresenterProtocol) {
        super.init(presenter: presenter, nibName: "CoinDetailsViewController")
        
        self.modalPresentationStyle = .overCurrentContext
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // ************************************************
    // MARK: UIViewController Lifecycle
    // ************************************************

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupOnLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.25, animations: {
            [weak self] in
            self?.view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        })
    }
    
    // ************************************************
    // MARK: Setup
    // ************************************************
    
    override func bind() {
        super.bind()
    }
    
    private func setupOnLoad() {

        // rounded...
        containerView.layer.cornerRadius = 10.0
        containerView.clipsToBounds = true

        self.titleLabel.text = "\(_presenter.coin.name) \(Strings.coinDetailsTitle())"

        self.loadData()
    }
    
    //*************************************************
    // MARK: - Data
    //*************************************************
    
    private func loadData() {
        
        let coin = _presenter.coin
        
        rankLabel.text = coin.rank
        symbolLabel.text = coin.symbol
        nameLabel.text = coin.name
        priceUSDLabel.text = coin.priceUSD
        priceBTCLabel.text = coin.priceBTC
        volumeUSD_24hLabel.text = coin.volumeUSD_24h
        marketCapUSDLabel.text = coin.marketCapUSD
        availableSupplyLabel.text = coin.availableSupply
        totalSupplyLabel.text = coin.totalSupply
        maxSupplyLabel.text = coin.maxSupply
        percentChange_1hLabel.text = coin.percentChange_1h
        percentChange_24hLabel.text = coin.percentChange_24h
        percentChange_7dLabel.text = coin.percentChange_7d
        lastUpdatedLabel.text = coin.lastUpdated
    }

    //*************************************************
    // MARK: Navigation
    //*************************************************
    
    private func close() {
        
        UIView.animate(
            withDuration: 0.25,
            animations: {
                [unowned self] in
                
                self.view.backgroundColor = UIColor.clear
            },
            completion: {
                [unowned self] (result) in
                
                self.dismiss(animated: true, completion: nil)
            }
        )
    }
}
