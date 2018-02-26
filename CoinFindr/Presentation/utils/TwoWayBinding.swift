//
//  TwoWayBinding.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

infix operator <->

// Two-Way binding (UI -> Variable)
func <-> <T>(property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
    
    let variableToProperty = variable
        .asObservable()
        .bind(to: property)
    
    let propertyToVariable = property.subscribe(onNext: { n in
        variable.value = n
    }, onCompleted: {
        variableToProperty.dispose()
    })
    
    return CompositeDisposable(variableToProperty, propertyToVariable)
}
