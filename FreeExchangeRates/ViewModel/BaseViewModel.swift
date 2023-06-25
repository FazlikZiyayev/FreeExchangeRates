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
    var isLoadingSupportedSymbols: Observable<Bool> = Observable(false)
    
    var exchangeData: Observable<ExchangeRateModel> = Observable(nil)
    var supportedSymbols: Observable<SupportedSymbols> = Observable(nil)

    var baseCurrency: Observable<String> = Observable("EUR")
    var targetCurrency: Observable<String> = Observable(nil)
    
    var convertedResult: Observable<String> = Observable(nil)

    
    func getBaseCurrency() -> String?
    {
        return self.baseCurrency.value
    }
    
    
    
    func setBaseCurrency(baseCurrency: String?)
    {
        self.baseCurrency.value = baseCurrency
    }
    
    
    
    func getTargetCurrency() -> String?
    {
        return self.targetCurrency.value
    }
    
    
    
    func setTargetCurrency(targetCurrency: String?)
    {
        self.targetCurrency.value = targetCurrency
    }
    
    
    
    func getNumberOfSupportedSymbols() -> Int?
    {
        return self.supportedSymbols.value?.symbols.count
    }
    
    
    
    func getSupportedSymbolKeyByIndex(index: Int) -> String?
    {
        if let safeSupportedSymbols = self.supportedSymbols.value?.symbols
        {
            let index = safeSupportedSymbols.index(safeSupportedSymbols.startIndex, offsetBy: index)
            let value = safeSupportedSymbols.keys[index]
            
            return value
        }
        
        return nil
    }
    

    
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
    
    
    
    func getSupportedSymbols()
    {
        if isLoadingSupportedSymbols.value ?? true
        {
            return
        }
        
        isLoadingSupportedSymbols.value = true
        
        APICaller.getSupportedSymbols { [weak self] result in
            self?.isLoadingSupportedSymbols.value = false
            
            switch result
            {
            case .success(let data):
                self?.supportedSymbols.value = data
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    func convert(amount: String)
    {
        if let safeExchangeData = self.exchangeData.value,
           let targetCurrency = self.getTargetCurrency(),
           let parsedAmount = Double(amount.trimmingCharacters(in: [" "]))
        {
            if let safeSingleCurrency = safeExchangeData.rates[targetCurrency]
            {
                self.convertedResult.value = "\(safeSingleCurrency * parsedAmount)"
            }
        }
    }
    
    
    func countryFlag(countryCode: String) -> String {
        let base = 127397
        var tempScalarView = String.UnicodeScalarView()
        for i in countryCode.utf16 {
            if let scalar = UnicodeScalar(base + Int(i)) {
                tempScalarView.append(scalar)
            }
        }
        return String(tempScalarView)
    }
}
