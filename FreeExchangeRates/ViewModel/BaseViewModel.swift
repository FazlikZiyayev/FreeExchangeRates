//
//  BaseViewModel.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 23/06/23.
//

import Foundation

class BaseViewModel
{
    func getLatestRates()
    {
        APICaller.getLatestRates { result in
            switch result
            {
            case .success(let data):
                print(data)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
