//
//  MainViewController.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    private var presenter: MainPresenterProtocol {
        return basePresenter as! MainPresenterProtocol
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red
        presenter.viewDidAppear()
    }
    
    override func bind() {
        super.bind()
    }
}
