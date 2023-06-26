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
    var sortedSupportedSymbols: Observable<[String]> = Observable(nil)

    var baseCurrency: Observable<String> = Observable("EUR")
    var targetCurrency: Observable<String> = Observable(nil)
    
    var convertedResult: Observable<String> = Observable(nil)
    
    var isSameLatestRates: Observable<Bool> = Observable(nil)

    
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
    
    
    func getNumberOfComponents() -> Int
    {
        return 1
    }
    
    
    func getNumberOfSupportedSymbols() -> Int?
    {
        return self.supportedSymbols.value?.symbols.count
    }
    
    
    func getNumberOfSortedSupportedSymbols() -> Int?
    {
        return self.sortedSupportedSymbols.value?.count
    }
    
    
    func getSortedSupportedSymbolKeyByIndex(index: Int) -> String?
    {
        if let safeSortedSupportedSymbols = self.sortedSupportedSymbols.value,
           index < safeSortedSupportedSymbols.count
        {
            return safeSortedSupportedSymbols[index]
        }
        
        return nil
    }
    
    
    // The free subscription does not allow change base currency
    // By default it is EUR
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
                if let safeOldExchangeData = self?.exchangeData.value,
                   let targetCurrency = self?.getTargetCurrency()
                {
                    if let safeOldSingleCurrency = safeOldExchangeData.rates[targetCurrency],
                       let safeNewSingleCurrency = data.rates[targetCurrency]
                    {
                        self?.isSameLatestRates.value = safeOldSingleCurrency == safeNewSingleCurrency
                    }
                }
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
    
    
    
    func sortSupportedSymbolsByKey()
    {
        if let safeSupportedSymbols = self.supportedSymbols.value?.symbols
        {
            let sortedDictArray = Array(safeSupportedSymbols.sorted { $0.key < $1.key }.map({ $0.key }))
            self.sortedSupportedSymbols.value = sortedDictArray
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
