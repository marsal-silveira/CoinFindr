//
//  ClientAPI.swift
//  CoinFindr
//
//  Created by Marsal Silveira.
//  Copyright © 2018 Marsal Silveira. All rights reserved.
//

import Foundation
import Moya

protocol CoinMarketCapAPIProtocol {

    func tickers(limit: Int) //-> Single<[WorkoutTypeAPI]>
}

/// it will contain all methods to do interactions with api, to be simpler to change if necessary
class CoinMarketCapAPI: CoinMarketCapAPIProtocol {
    
    private static let _apiVersion = "/v1"
    fileprivate static let baseURL = URL(string: "https://api.coinmarketcap.com" + _apiVersion)!
    
    private lazy var provider = MoyaProvider<CoinMarketCapAPITarget>(
        
        endpointClosure: { (target) -> Endpoint<CoinMarketCapAPITarget> in
            
            return Endpoint<CoinMarketCapAPITarget>(
                url: "\(target.baseURL)\(target.path)",
                sampleResponseClosure: { .networkResponse(200, target.sampleData) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        },
        plugins: [
            NetworkActivityPlugin { (change, _) in UIApplication.shared.isNetworkActivityIndicatorVisible = change == .began },
            NetworkLoggerPlugin(verbose: true)
        ]
    )
    
    func tickers(limit: Int) { //-> Single<[WorkoutTypeAPI]> {
        
        self.provider.request(.tickers(limit: 10)) { (result) in
            print("result -> \(result)")
        }
        //        return provider.rx
        //            .request(.training(exerciseTypeIds: exerciseTypeIds, minutes: minutes))
        //            .processResponse()
        //            .mapArray(SampleVideoAPI.self)
    }
}

enum CoinMarketCapAPITarget {
    
    case tickers(limit: Int)
}

extension CoinMarketCapAPITarget: TargetType {
    
    var baseURL: URL {
        return CoinMarketCapAPI.baseURL
    }
    
    var path: String {
        switch self {
        case .tickers(let limit):
            return "/ticker/?limit=\(limit)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .get
        }
    }
    
    var headers: [String: String]? {
        
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Accept-Language": "pt-BR"
        ]
        return headers
    }
    
    var parameters: [String: Any]? {
        return nil
    }
    
    var parameterEncoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
}
