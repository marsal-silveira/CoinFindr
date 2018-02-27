//
//  ClienteAPIOperations.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper
import Result

public enum APIError: Swift.Error, LocalizedError, CustomStringConvertible {
    case error(description: String)
    
    public var errorDescription: String? {
        switch self {
        case .error(let description):
            return description
        }
    }
    
    public var description: String {
        return errorDescription ?? ""
    }
}

extension Data {
    
    var asJSON: Result<[String: Any], NSError> {
        do {
            guard let JSONDict = try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any] else {
//                return Result.failure(APIError.error(description: R.string.localizable.errorParseJson()) as NSError)
                // TODO: check this
                return Result.failure(APIError.error(description: "Error parsing json") as NSError)
            }
            return Result.success(JSONDict)
        } catch let error as NSError {
            return Result.failure(error)
        }
    }
}

extension PrimitiveSequence where TraitType == SingleTrait, ElementType == Response {
    
    func processResponse() -> Single<Moya.Response> {
        
        return flatMap({ response -> Single<Moya.Response> in
            if response.statusCode >= 200 && response.statusCode <= 299 {
                
                return Single.just(response)
            }
            else {
                switch response.data.asJSON {
                case .success(let JSONDict):
                    print(JSONDict)
                    // TODO: check this
//                    if let errorAPI = Mapper<ErrorAPI>().map(JSON: JSONDict) {
//                        return Single.error(APIError.error(description: errorAPI.localizedDescription))
//                    } else {
//                        return Single.error(APIError.error(description: R.string.localizable.errorParseJson()))
                    return Single.error(APIError.error(description: "Error parsing json"))
//                    }
                case .failure(let error):
                    return Single.error(error)
                }
            }
        })
    }
}
