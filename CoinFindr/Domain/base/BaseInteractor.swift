//
//  BaseInteractor.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

class BaseInteractor {

    deinit {
        print("dealloc ---> \(String(describing: type(of: self)))")
    }
}
