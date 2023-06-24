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
    
    
    
    func create_amountLabel() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Amount"
        label.font = .boldSystemFont(ofSize: 17)
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.equalToSuperview().offset(16)
        }
        
        
        return label
    }
    
    
    
    func create_baseAmountContainer() -> UIView
    {
        let container = UIView()
        container.layer.borderWidth = 2.0
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.cornerRadius = 4
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalTo(self.baseAmountLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        
        return container
    }
    
    
    
    func create_baseAmountTF() -> UITextField
    {
        let tf = UITextField()
        tf.delegate = self
        tf.font = .boldSystemFont(ofSize: 20)
        tf.autocorrectionType = .no
        tf.keyboardType = .numberPad
        tf.addTarget(self, action: #selector(baseAmountTFChanged), for: .editingChanged)
        self.baseAmountContainer.addSubview(tf)
        tf.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview()
            make.left.equalToSuperview().offset(8)
        }
        
        return tf
    }
    
    
    
    func create_baseCurrencyLabel() -> UILabel
    {
        let label = UILabel()
        label.text = "EUR"
        label.font = .boldSystemFont(ofSize: 20)
        self.baseAmountContainer.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
        }
        
        
        return label
    }
    
    
    
    
    func create_baseCurrencyFlag() -> UIImageView
    {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "")
        self.baseAmountContainer.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        
        return imageView
    }
}
