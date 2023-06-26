//
//  NetworkConstant.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 23/06/23.
//

import Foundation

class NetworkConstant
{
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init()
    {
        
    }
    
    
    public var apiKey: String
    {
        get {
            // YOUR API KEY
            return "a7d759acd3a6b410e3789f066c02cf80"
        }
    }
    
    
    public var serverEndpoint: String
    {
        get {
            return "http://api.exchangeratesapi.io/v1/"
        }
    }
}
