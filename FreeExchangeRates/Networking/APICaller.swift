//
//  APICaller.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 23/06/23.
//

import Foundation

enum NetworkError: Error
{
    case urlError
    case couldNotParseData
}


class APICaller
{
    static func getLatestRates(completionHandler: @escaping (Result<ExchangeRateModel, NetworkError>) -> Void)
    {
        let url = NetworkConstant.shared.serverEndpoint +
        "latest?access_key=" +
        NetworkConstant.shared.apiKey
        
        guard let url = URL(string: url) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error == nil,
               let safeData = data,
               let resultData = try? JSONDecoder().decode(ExchangeRateModel.self, from: safeData)
            {
                completionHandler(.success(resultData))
            }
            else
            {
                completionHandler(.failure(.couldNotParseData))
            }
        }.resume()
    }
    
    
    
    static func getSupportedSymbols(completionHandler: @escaping (Result<SupportedSymbols, NetworkError>) -> Void)
    {
        let url = NetworkConstant.shared.serverEndpoint +
        "symbols?access_key=" +
        NetworkConstant.shared.apiKey
        
        guard let url = URL(string: url) else {
            completionHandler(.failure(.urlError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil,
               let safeData = data,
               let resultData = try? JSONDecoder().decode(SupportedSymbols.self, from: safeData)
            {
                completionHandler(.success(resultData))
            }
            else
            {
                completionHandler(.failure(.couldNotParseData))
            }
        }.resume()
    }
}
