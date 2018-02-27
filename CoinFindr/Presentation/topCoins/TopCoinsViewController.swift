//
//  TopCoinsViewController.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit
import Cartography
import RxSwift
import RxCocoa

class TopCoinsViewController: BaseViewController {
    
    // ************************************************
    // MARK: Properties
    // ************************************************

    private var _presenter: TopCoinsPresenterProtocol {
        return basePresenter as! TopCoinsPresenterProtocol
    }
    
    fileprivate var _coins = [Coin]()
    
    // ************************************************
    // MARK: UI Components
    // ************************************************
    
    fileprivate lazy var _refreshControl: UIRefreshControl = {

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TopCoinsViewController.handleRefresh(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.customBlue
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
        
        // remove all empyt rows and line separator
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        // register cells
        tableView.register(CoinCell.self)
        
        return tableView
    }()

    private lazy var _refreshButton: UIBarButtonItem = {
        
        let refreshButton = UIBarButtonItem()
        refreshButton.image = Images.refresh()
        
        _ = refreshButton.rx.tap
            .takeUntil(rx.deallocated)
            .bind {
                [weak self] in
                self?.loadData()
            }
        
        return refreshButton
    }()
    
    // ************************************************
    // MARK: UIViewController Lifecycle
    // ************************************************

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
            .bind(onNext: { [weak self] (TopCoins) in
                guard let strongSelf = self else { return }
                strongSelf.reloadData(with: TopCoins)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupOnLoad() {
        
        self.title = Strings.topCoinsTitle()
        
        self.addRefreshButton()
        self.addTableView()
        self.loadData()
    }
    
    private func addRefreshButton() {
        self.navigationItem.rightBarButtonItem = _refreshButton
    }
    
    private func addTableView() {
        self.view.addSubview(_tableView)
        constrain(view, _tableView) { (container, tableView) in
            tableView.edges == container.edges
        }
    }
    
    //*************************************************
    // MARK: - Pull To Refresh
    //*************************************************

    @objc private func handleRefresh(_ refreshControl: UIRefreshControl) {

//        _refreshControl.endRefreshing()
        self.loadData()
    }

    //*************************************************
    // MARK: - Data
    
    //*************************************************
    
    private func reloadData(with TopCoins: [Coin]) {
        
        _refreshControl.endRefreshing()
        
        _coins.removeAll()
        _coins.append(contentsOf: TopCoins)
        
        _tableView.reloadData()
    }

    private func loadData() {
        _presenter.getCoins()
    }
}

// ************************************************
// MARK: - UITableViewDataSource
// ************************************************

extension TopCoinsViewController: UITableViewDataSource {

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _coins.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CoinCell
        cell.setup(coin: _coins[indexPath.row])

        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.4) {
            cell.transform = CGAffineTransform.identity
        }

        return cell
    }
}

// ************************************************
// MARK: - UITableViewDelegate
// ************************************************

extension TopCoinsViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
