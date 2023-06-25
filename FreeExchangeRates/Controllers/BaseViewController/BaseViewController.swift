//
//  BaseViewController.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 23/06/23.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController
{
    let baseViewModel = BaseViewModel()
    
    var baseAmountLabel = UILabel()
    var baseAmountContainer = UIView()
    var baseAmountTF = UITextField()
    var baseCurrencyLabel = UILabel()
    
    var targetAmountLabel = UILabel()
    var targetAmountContainer = UIView()
    var targetCurrencyLabel = UILabel()
    
    var convertedResultLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.baseViewModel.setTargetCurrency(targetCurrency: "UZS")
        self.create_uiComponents()
        self.bind_elements()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setup_view()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.baseViewModel.getLatestRates()
        self.baseViewModel.getSupportedSymbols()
    }
    
    
    
    @objc func baseAmountTFChanged(_ tf: UITextField)
    {
//        self.baseViewModel.convert(from: "EUR", to: "UZS", amount: tf.text ?? "")
        if let safeText = tf.text,
           safeText.count > 0
        {
            self.convertedResultLabel.isHidden = false
            self.baseViewModel.convert(amount: safeText)
        }
        else
        {
            self.convertedResultLabel.isHidden = true
        }
    }
    
    
    
    @objc func selectTargetPressed()
    {
        
    }
}



// for binding elements
extension BaseViewController
{
    func bind_elements()
    {
        self.bind_isLoadingLastestRatest()
        self.bind_exchangeData()
        self.bind_supportedSymbols()
        self.bind_baseCurrency()
        self.bind_targetCurrency()
        self.bind_convertedResult()
    }
    
    
    
    func bind_isLoadingLastestRatest()
    {
//        baseViewModel.isLoadingLatestRates.bind { [weak self] isLoading in
//        }
    }
    
    
    
    func bind_exchangeData()
    {
        baseViewModel.exchangeData.bind { [weak self] exchangeDate in
            guard let self = self,
                  let _ = exchangeDate else {return}
            self.baseAmountTF.becomeFirstResponder()
            
        }
    }
    
    
    
    func bind_supportedSymbols()
    {
        baseViewModel.supportedSybols.bind { [weak self] supportedSymbols in
            guard let self = self,
                  let _ = supportedSymbols else {return}
            
            self.targetAmountContainer.isUserInteractionEnabled = true
        }
    }
    
    
    
    func bind_baseCurrency()
    {
        baseViewModel.baseCurrency.bind { [weak self] baseCurrencyStr in
            guard let self = self,
                  let baseCurrencyStr = baseCurrencyStr else { return }
            
            self.baseCurrencyLabel.text = self.baseViewModel.countryFlag(countryCode: "DE") + " \(baseCurrencyStr)"
        }
    }
    
    
    
    func bind_targetCurrency()
    {
        baseViewModel.targetCurrency.bind { [weak self] targetCurrencyStr in
            guard let self = self else { return }
            
            if let safeTargetCurrencyStr = targetCurrencyStr
            {
                self.targetCurrencyLabel.text = "\(safeTargetCurrencyStr)"
            }
            else
            {
                self.targetCurrencyLabel.text = "Select currency"
            }
        }
    }
    
    
    
    func bind_convertedResult()
    {
        baseViewModel.convertedResult.bind { [weak self] convertedResult in
            guard let self = self,
            let safeConvertedResult = convertedResult,
            let safeConvertedResultAsDouble = Double(safeConvertedResult) else { return }
            
            self.convertedResultLabel.text = String(format: "%.2f", safeConvertedResultAsDouble)
        }
    }
}



extension BaseViewController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
}
