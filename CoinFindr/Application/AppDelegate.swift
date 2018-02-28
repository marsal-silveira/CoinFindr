//
//  AppDelegate.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private var _container: ContainerRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // configure background fetch
        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        _container = ContainerRouter()
        _container?.presentOn(window: window)
        
        self.window = window
        
        return true
    }
}

// ************************************************
// MARK: Background Fetch
// ************************************************

extension AppDelegate {
    
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        // when background fetch was fired we refresh the coins using repository pool
        RepositoryPool.shared.coinRepository.getTopCoins()
        completionHandler(UIBackgroundFetchResult.newData)
    }
}
