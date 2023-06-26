//
//  ModalView.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 25/06/23.
//

import UIKit

// Need to present this class
class ModalView: UIViewController {
    
    var viewTitle: String = ""
    
    
    init(viewTitle: String)
    {
        self.viewTitle = viewTitle
        super.init(nibName: nil,
                   bundle: nil)
    }
    
    required init?(coder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.create_UI()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0)
        {
            self.dismiss(animated: true)
        }
    }
    
    
    func create_UI()
    {
        self.view.backgroundColor = .white.withAlphaComponent(0.7)
        self.create_container()
    }
    
    
    
    func create_container()
    {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 14
        container.layer.borderWidth = 3.0
        container.layer.borderColor = UIColor.gray.cgColor
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo((UIScreen.main.bounds.height / 100) * 30)
        }
    }
}
