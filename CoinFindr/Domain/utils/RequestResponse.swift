//
//  RequestResponse.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import UIKit

enum RequestResponse<T> {
    case new
    case loading
    case success(T)
    case failure(Error)
    case cancelled
}
