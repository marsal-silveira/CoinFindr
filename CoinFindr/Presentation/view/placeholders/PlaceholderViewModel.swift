//
//  LoadingViewModel.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit

enum PlaceholderType {
    
    case loading
    case error
}

struct PlaceholderViewModel {
    
    private var _text: String?
    var text: String? { return _text }
    
    private var _details: String?
    var details: String? { return _details }
    
    init(text: String? = nil, details: String? = nil) {
        _text = text
        _details = details
    }
}
