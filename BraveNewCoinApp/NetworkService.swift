//
//  NetworkService.swift
//  BraveNewCoinApp
//
//  Created by Sinan Kulen on 2.03.2022.
//

import Foundation

protocol NetworkServiceProtocol
{
    func get<T:Decodable>(from endPoint: String, completion:@escaping (T?,NetworkError?)->Void)
}

enum NetworkError: Error
{
    case invalidURL
    case custom(String?)
    case noData
    case decoding(String?)
}

class NetworkService
{
    private let baseURL = "https://bravenewcoin.p.rapidapi.com"
    private let auth = "/oauth/token"
    private let market = "/market"
    private let asset = "/asset"
    
    func get<T:Decodable>(from endPoint: String, completion:@escaping (T?,NetworkError?)->Void)
    {
        guard let url = URL(string: baseURL + endPoint) else
        {
        completion(nil, NetworkError.invalidURL)
        return
        }
        
        let headers = [ "x-rapidapi-host": "bravenewcoin.p.rapidapi.com",
                        "x-rapidapi-key": "f55d81b597mshed87f7780f5ff97p17046cjsna3b381cb7268"]
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        createDataTask(from: request, completion: completion).resume()
    }
    
    func createDataTask<T:Decodable>(from request: URLRequest, completion:@escaping (T?, NetworkError?)->Void)->URLSessionDataTask
    {
        return URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard error == nil else
            {
                completion(nil, NetworkError.custom(error!.localizedDescription))
                return
            }
            
            guard let data = data else
            {
                completion(nil, NetworkError.noData)
                return
            }
            
            do
            {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(decodedData,nil)
            }
            catch
            {
                completion(nil, NetworkError.decoding(error.localizedDescription))
            }

        }
    }
}
