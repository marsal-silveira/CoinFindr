//
//  EventTranslation.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Moya
import RxSwift

public enum AppError {
    case network
    case apiError(APIError)
    case unknown
}

public func transformEvent<T>(event: RxSwift.SingleEvent<T>) -> RxSwift.SingleEvent<T> {
    switch event {
        
    case .success(let element):
        return SingleEvent.success(element)
        
    case .error(let error):
        let appError = extractError(errorType: error)
        
        switch appError {
            
        case .apiError(let error):
            return SingleEvent.error(error)
            
        case .network:
            return SingleEvent.error(APIError.error(description: Strings.errorNetwork()))
            
        case .unknown:
            return SingleEvent.error(error)
        }
    }
}

private func extractError(errorType: Swift.Error) -> AppError {
    if let apiError = errorType as? APIError {
        return AppError.apiError(apiError)
    }
    
    let error = translateMoyaError(errorType: errorType)
    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
        return AppError.network
    }
    
    return AppError.unknown
}

private func translateMoyaError(errorType: Swift.Error) -> NSError {
    if let moyaError = errorType as? Moya.MoyaError {
        switch moyaError {
        case .underlying(let error, _):
            return error as NSError
        default:
            return moyaError as NSError
        }
    } else {
        return errorType as NSError
    }
}
