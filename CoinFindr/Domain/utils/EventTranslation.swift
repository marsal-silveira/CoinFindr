//
//  EventTranslation.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Moya
import RxSwift

public enum BBSError {
    case network
    case apiError(APIError)
    case unknown
}

public func transformEvent<T>(event: RxSwift.SingleEvent<T>) -> RxSwift.SingleEvent<T> {
    switch event {
        
    case .success(let element):
        return SingleEvent.success(element)
        
    case .error(let error):
        let bbsError = extractError(errorType: error)
        
        switch bbsError {
            
        case .apiError(let error):
            return SingleEvent.error(error)
            
        case .network:
//            return SingleEvent.error(APIError.error(description: R.string.localizable.errorNetwork()))
            // TODO: check this
            return SingleEvent.error(APIError.error(description: "Error"))
            
        case .unknown:
            return SingleEvent.error(error)
        }
    }
}

private func extractError(errorType: Swift.Error) -> BBSError {
    if let apiError = errorType as? APIError {
        return BBSError.apiError(apiError)
    }
    
    let error = translateMoyaError(errorType: errorType)
    if error.code == NSURLErrorNotConnectedToInternet || error.code == NSURLErrorNetworkConnectionLost {
        return BBSError.network
    }
    
    return BBSError.unknown
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
