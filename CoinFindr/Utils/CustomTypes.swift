//
//  CustomTypes.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation

//*************************************************
// MARK: - Clousures
//*************************************************

public typealias VoidClousure = () -> ()

//*************************************************
// MARK: - Misc
//*************************************************

public typealias JSON = [String : Any]

//*************************************************
// MARK: - Operators
//*************************************************

prefix operator ❗️
prefix public func ❗️(a: Bool) -> Bool { return !a }

// *************************************************
// MARK: - Resources (Wrapper to R.swift)
// *************************************************

typealias Strings = R.string.localizable
typealias Images = R.image
