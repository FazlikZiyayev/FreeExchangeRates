//
//  BaseViewModel.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 23/06/23.
//

import Foundation

class BaseViewModel
{
    var isLoadingLatestRates: Observable<Bool> = Observable(false)
    var exchangeData: Observable<ExchangeRateModel> = Observable(nil)
    
    
    var convertedResult: Observable<String> = Observable(nil)


    func getLatestRates()
    {
        if isLoadingLatestRates.value ?? true
        {
            return
        }
        
        isLoadingLatestRates.value = true
        
        APICaller.getLatestRates { [weak self] result in
            self?.isLoadingLatestRates.value = false
            
            switch result
            {
            case .success(let data):
                self?.exchangeData.value = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func convert(from: String,
                 to: String,
                 amount: String)
    {
        
    }
}
