//
//  CoinsViewController.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import Cartography
import RxSwift
import RxCocoa

class CoinsViewController: BaseViewController {
    
    // ************************************************
    // MARK: Properties
    // ************************************************

    private var _presenter: CoinsPresenterProtocol {
        return basePresenter as! CoinsPresenterProtocol
    }
    
    fileprivate var _coins = [Coin]()
    private let _disposeBag = DisposeBag()
    
    // ************************************************
    // MARK: UI Components
    // ************************************************
    
    fileprivate lazy var _refreshControl: UIRefreshControl = {

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(CoinsViewController.handleRefresh(_:)), for: .valueChanged)
//        refreshControl.tintColor = Colors.coolBlue()
        refreshControl.alpha = 0.75

        return refreshControl
    }()
    
    private lazy var _tableView: UITableView = {
        
        let tableView = UITableView()
        
        // set delegate and dataSource
        tableView.dataSource = self
        tableView.delegate = self
        
        // RefreshControll (Pull to Refresh)
        tableView.refreshControl = _refreshControl
        
        // set estimated row height and enabled "dynamic height"
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // remove all empyt rows
        tableView.tableFooterView = UIView()
        
        // register cells
        tableView.register(CoinCell.self)
        
        return tableView
    }()
    
    // ************************************************
    // MARK: UIViewController Lifecycle
    // ************************************************
    
    override func loadView() {
        super.loadView()
        
        self.addTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupOnLoad()
    }
    
    // ************************************************
    // MARK: Setup
    // ************************************************
    
    override func bind() {
        super.bind()
        
        _presenter.coins
            .bind(onNext: { [weak self] (coins) in
                guard let strongSelf = self else { return }
                strongSelf.reloadData(with: coins)
            })
            .disposed(by: _disposeBag)
    }
    
    private func addTableView() {
        
        self.view.addSubview(_tableView)
        constrain(view, _tableView) { (container, tableView) in
            tableView.edges == container.edges
        }
    }
    
    private func setupOnLoad() {
        self.loadData()
    }
    
    //*************************************************
    // MARK: - Pull To Refresh
    //*************************************************

    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {

//        _refreshControl.endRefreshing()
//        self.loadData()
    }

    //*************************************************
    // MARK: - Data
    //*************************************************
    
    private func reloadData(with coins: [Coin]) {
        
        _coins.removeAll()
        _coins.append(contentsOf: coins)
        
        _tableView.reloadData()
    }

    private func loadData() {
        _presenter.getCoins()
    }
}

// ************************************************
// MARK: - UITableViewDataSource
// ************************************************

extension CoinsViewController: UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _coins.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CoinCell
        cell.setup(coin: _coins[indexPath.row])
        
        return cell
    }
}

// ************************************************
// MARK: - UITableViewDelegate
// ************************************************

extension CoinsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        _presenter?.didSelect(_rooms[indexPath.row])
    }
}
