//
//  ExchangeRateModel.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 23/06/23.
//

import Foundation

struct ExchangeRateModel: Codable
{
    let success: Bool
    let timestamp: Int
    let base: String
    let date: String
    let rates: [String:Double]
}
