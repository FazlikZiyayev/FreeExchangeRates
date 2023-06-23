//
//  BaseView-UI.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 24/06/23.
//

import UIKit

extension BaseViewController
{
    func setup_view()
    {
        self.title = "Currency Converter"
        self.view.backgroundColor = .white
    }
    
    
    func create_label() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        
        return label
    }
    
    
    
    
}
