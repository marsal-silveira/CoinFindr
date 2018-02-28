//
//  RepositoryPool.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation

/// Main entity repository pool. Get an entity repository instance instead instantiate them manually.
class RepositoryPool {

    // to avoid instanciate outside
    private init() {}
    
    // singleton
    private static var _shared: RepositoryPool = RepositoryPool()
    static var shared: RepositoryPool { return _shared }

    // each entity will have a repository here
    
    // Coin
    private lazy var _coinRepository: CoinRepository = {
        return CoinRepository(apiClient: CoinMarketCapAPI())
    }()
    var coinRepository: CoinRepository { return _coinRepository }
}
