//
//  BaseView-UI.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 24/06/23.
//

import UIKit

extension BaseViewController
{
    func create_uiComponents()
    {
        self.baseAmountLabel = self.create_baseAmountLabel()
        self.baseAmountContainer = self.create_baseAmountContainer()
        self.baseAmountTF = self.create_baseAmountTF()
        self.baseCurrencyLabel = self.create_baseCurrencyLabel()
        
        self.targetAmountLabel = self.create_targetAmounLabel()
        self.targetAmountContainer = self.create_targetAmountContainer()
        self.targetCurrencyLabel = self.create_targetCurrencyLabel()
        
        self.convertedResultLabel = self.create_label()
    }
    
    
    func setup_view()
    {
        self.title = "Currency Converter"
        self.view.backgroundColor = .white
    }
    
    
    func create_label() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "#228B22")
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(self.targetAmountContainer.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
        }
        
        
        return label
    }
    
    
    func create_baseAmountLabel() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Amount"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black.withAlphaComponent(0.8)
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
        label.text = self.countryFlag(countryCode: "DE") + " EUR"
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
    
    
    func create_targetAmounLabel() -> UILabel
    {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Target currency"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .black.withAlphaComponent(0.8)
        self.view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(self.baseAmountContainer.snp.bottom).offset(100)
            make.left.equalToSuperview().offset(16)
        }
        
        
        return label
    }
    
    
    func create_targetAmountContainer() -> UIView
    {
        let container = UIView()
        container.layer.borderWidth = 2.0
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.cornerRadius = 4
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalTo(self.targetAmountLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        
        return container
    }
    
    
    func create_targetCurrencyLabel() -> UILabel
    {
        let label = UILabel()
        label.text = "Select currency"
        label.font = .boldSystemFont(ofSize: 20)
        self.targetAmountContainer.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        
        return label
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
