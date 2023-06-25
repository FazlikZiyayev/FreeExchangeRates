//
//  SupportedSybols.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 25/06/23.
//

import Foundation

struct SupportedSymbols: Codable
{
    let success: Bool
    let symbols: [String:String]
}
