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
        
    }
}



// for binding elements
extension BaseViewController
{
    func bind_isLoadingLastestRatest()
    {
        baseViewModel.isLoadingLatestRates.bind { [weak self] isLoading in
            print(isLoading ?? false)
        }
    }
    
    
    
    func bind_exchangeData()
    {
        baseViewModel.exchangeData.bind { [weak self] exchangeDate in
            guard let self = self,
                  let safeExchangeDate = exchangeDate else {return}
            self.label.text = safeExchangeDate.date
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
