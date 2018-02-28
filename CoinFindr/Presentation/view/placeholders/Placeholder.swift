//
//  Placeholder.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import UIKit

protocol Placeholder {

    func present(on parent: UIView)
    func dismiss()
}

struct LoadingViewModel {

    private var _text: String?
    var text: String? { return _text }

    init(text: String? = nil) {
        _text = text
    }
}

struct ErrorViewModel {

    private var _text: String?
    var text: String? { return _text }

    private var _details: String?
    var details: String? { return _details }

    init(text: String? = nil, details: String? = nil) {
        _text = text
        _details = details
    }
}

enum PlaceholderType {

    case loading(LoadingViewModel)
    case error(ErrorViewModel)
}
