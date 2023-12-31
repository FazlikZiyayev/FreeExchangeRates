//
//  BaseView-UI.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 24/06/23.
//

import UIKit
import KeyboardLayoutGuide

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
        self.create_targetOptionIcon()
        
        self.convertedResultLabel = self.create_label()
        
        self.submitBtn = self.create_submitBtn()
        
        self.modalView = self.create_modalView()
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
        container.isUserInteractionEnabled = false
        container.layer.borderWidth = 2.0
        container.layer.borderColor = UIColor.black.cgColor
        container.layer.cornerRadius = 4
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.top.equalTo(self.targetAmountLabel.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(50)
        }
        
        
        let clearBtn = UIButton()
        clearBtn.addTarget(self, action: #selector(selectTargetPressed), for: .touchUpInside)
        container.addSubview(clearBtn)
        clearBtn.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
        }
        
        self.selectTargetClearBtn = clearBtn
        
        
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
    
    
    func create_targetOptionIcon()
    {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "optionIcon")
        self.targetAmountContainer.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.right.equalToSuperview().offset(-12)
            make.centerY.equalToSuperview()
        }
    }
    
    
    func create_submitBtn() -> UIButton
    {
        let btn = UIButton()
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor.black.cgColor
        btn.setTitle("Submit", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(submitBtnPressed), for: .touchUpInside)
        self.view.addSubview(btn)
        btn.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(50)
            make.bottom.equalTo(self.view.keyboardLayoutGuide.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        
        return btn
    }
    

    func create_modalView() -> UIView
    {
        let topContainer = UIView()
        topContainer.isHidden = true
        topContainer.backgroundColor = .white.withAlphaComponent(0.85)
        self.view.addSubview(topContainer)
        topContainer.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
        
        
        let container = UIView()
        container.tag = 111
        container.backgroundColor = .white
        container.layer.cornerRadius = 14
        container.layer.borderWidth = 3.0
        container.layer.borderColor = UIColor.gray.cgColor
        topContainer.addSubview(container)
        container.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo((UIScreen.main.bounds.height / 100) * 30)
        }
        
        
        let label = UILabel()
        label.tag = 222
        label.text = "Success ✅"
        label.font = .boldSystemFont(ofSize: 25)
        container.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        
        return topContainer
    }
    
    
    func logicForConvertingCurrency()
    {
        if let safeText = self.baseAmountTF.text,
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
    
    
    func checkForSubmitBtn()
    {
        
    }
    
    
    func openTargetPickerView()
    {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height:screenHeight))
        pickerView.dataSource = self
        pickerView.delegate = self
        
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        let alert = UIAlertController(title: "Select Currency", message: "", preferredStyle: .actionSheet)
        
        alert.popoverPresentationController?.sourceView = self.selectTargetClearBtn
        alert.popoverPresentationController?.sourceRect =  self.selectTargetClearBtn.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { [weak self] (UIAlertAction) in
            let key = self?.baseViewModel.getSortedSupportedSymbolKeyByIndex(index: pickerView.selectedRow(inComponent: 0))
            self?.baseViewModel.setTargetCurrency(targetCurrency: key)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showModalView(title: String)
    {
//        let vc = ModalView(viewTitle: "")
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc,
//                     animated: true)
        
        self.modalView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
        {
            self.modalView.isHidden = true
        }
    }
}
