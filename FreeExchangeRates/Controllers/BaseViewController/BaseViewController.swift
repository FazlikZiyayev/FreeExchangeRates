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
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.label = self.create_label()
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
            
            self.label.text = safeExchangeDate.date
        }
    }
}
