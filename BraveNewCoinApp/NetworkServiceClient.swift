//
//  NetworkServiceClient.swift
//  BraveNewCoinApp
//
//  Created by Sinan Kulen on 3.03.2022.
//

import Foundation

class NetworkServiceClient
{
    private enum Endpoints : String
    {
        case token = "/oauth/token"
        case market = "/market"
        case asset = "/asset"
    }
    
    private let networkService : NetworkServiceProtocol = NetworkService()
    
    func markets(completion: @escaping (MarketsDTO?,NetworkError?) -> Void)
    {
        let urlString = Endpoints.market.rawValue
        networkService.get(from: urlString, completion: completion)
    }
    
    func assets(completion: @escaping (AssetDTO?,NetworkError?) -> Void)
    {
        let urlString = Endpoints.asset.rawValue
        networkService.get(from: urlString, completion: completion)
    }
    
    func token(completion: @escaping (TokenDTO?,NetworkError?) -> Void)
    {
        let urlString = Endpoints.token.rawValue
        networkService.getToken(from: urlString, completion: completion)
    }
}
