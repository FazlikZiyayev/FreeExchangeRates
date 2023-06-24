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
    
    var label = UILabel()
    var baseAmountLabel = UILabel()
    var baseAmountContainer = UIView()
    var baseAmountTF = UITextField()
    
    var baseCurrencyLabel = UILabel()
    var baseCurrencyFlag = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.label = self.create_label()
        self.baseAmountLabel = self.create_amountLabel()
        self.baseAmountContainer = self.create_baseAmountContainer()
        self.baseAmountTF = self.create_baseAmountTF()
        self.baseCurrencyLabel = self.create_baseCurrencyLabel()
        self.bind_baseViewModel()
        self.bind_exchangeData()
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
        print(tf.text)
    }
    
    
    
    func bind_baseViewModel()
    {
        baseViewModel.isLoadingLatestRates.bind { [weak self] isLoading in
            
        }
    }
    
    
    
    func bind_exchangeData()
    {
        baseViewModel.exchangeData.bind { [weak self] exchangeDate in
            guard let self = self,
                  let safeExchangeDate = exchangeDate else {return}
            
//            self.label.text = safeExchangeDate.date
            self.baseCurrencyLabel.text = self.countryFlag(countryCode: "DE") + " EUR"
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



extension BaseViewController: UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
}
