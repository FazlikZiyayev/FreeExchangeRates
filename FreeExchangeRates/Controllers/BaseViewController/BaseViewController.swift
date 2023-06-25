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
    }
    
    
    
    @objc func baseAmountTFChanged(_ tf: UITextField)
    {
//        self.baseViewModel.convert(from: "EUR", to: "UZS", amount: tf.text ?? "")
        if let safeText = tf.text,
           safeText.count > 0
        {
            self.convertedResultLabel.isHidden = false
            self.baseViewModel.convert(from: "EUR", to: "USD", amount: safeText)
        }
        else
        {
            self.convertedResultLabel.isHidden = true
        }
    }
}



// for binding elements
extension BaseViewController
{
    func bind_elements()
    {
        self.bind_isLoadingLastestRatest()
        self.bind_exchangeData()
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
