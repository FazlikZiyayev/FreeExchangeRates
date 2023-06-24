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
    var amountLabel = UILabel()
    var amountContainer = UIView()
    var amountTF = UITextField()
    
    var baseCurrencyLabel = UILabel()
    var baseCurrencyFlag = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.label = self.create_label()
        self.amountLabel = self.create_amountLabel()
        self.amountContainer = self.create_amountContainer()
        self.amountTF = self.create_amountTf()
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
