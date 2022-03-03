//
//  ViewController.swift
//  BraveNewCoinApp
//
//  Created by Sinan Kulen on 2.03.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   //     takeToken()
   //     takeAssetTicker()
        takeMarket()
    }
    
    func takeToken()
    {
        let url = URL(string: "https://bravenewcoin.p.rapidapi.com/oauth/token")!
        
        let headers = ["content-type": "application/json",
                       "x-rapidapi-host": "bravenewcoin.p.rapidapi.com",
                       "x-rapidapi-key": "f55d81b597mshed87f7780f5ff97p17046cjsna3b381cb7268"]
        
        let body = ["audience": "https://api.bravenewcoin.com",
                    "client_id": "oCdQoZoI96ERE9HY3sQ7JmbACfBf55RY",
                    "grant_type": "client_credentials"] as [String:Any]
        
        let bodyData = try! JSONSerialization.data(withJSONObject: body, options: [])
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = bodyData as Data
       
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { data, response, error in
            if error != nil
            {
                print(error)
            }
            else
            {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                let decoder = JSONDecoder()
                let decodedData = try? decoder.decode(TokenModel.self, from: data!)
                print(decodedData)
                print(decodedData?.accessToken)
            }
        } .resume()

    }
    
    func takeAssetTicker()
    {
        let url = URL(string: "https://bravenewcoin.p.rapidapi.com/asset")!
        let headers = [
            "x-rapidapi-host": "bravenewcoin.p.rapidapi.com",
            "x-rapidapi-key": "f55d81b597mshed87f7780f5ff97p17046cjsna3b381cb7268"
                        ]

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                let jsonDecoder = JSONDecoder()
                let decoder = try? jsonDecoder.decode(AssetModel.self, from: data!)
                print(decoder)
                print(decoder?.content[0].name)
            }
        }
        dataTask.resume()
    }
    
    func takeMarket()
    {
        let url = URL(string: "https://bravenewcoin.p.rapidapi.com/market")!
        let headers = [
            "x-rapidapi-host": "bravenewcoin.p.rapidapi.com",
            "x-rapidapi-key": "f55d81b597mshed87f7780f5ff97p17046cjsna3b381cb7268"
                        ]

        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse)
                let jsonDecoder = JSONDecoder()
                let decoder = try? jsonDecoder.decode(MarketModel.self, from: data!)
                print(decoder)
                print(decoder?.content[0].baseAssetID)
            }
        }
        dataTask.resume()
    }
}
