//
//  BaseRouter.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

protocol RouterCallbackProtocol: class {
    func shouldDismissPresentedRouter()
}

class BaseRouter: NSObject {
    
    var presentedRouter: BaseRouter?
    weak var callback: RouterCallbackProtocol?

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}

extension BaseRouter: RouterCallbackProtocol {
    
    func shouldDismissPresentedRouter() {
        presentedRouter = nil
    }
}
