//
//  BaseViewController.swift
//  FreeExchangeRates
//
//  Created by Fazlik Ziyaev on 23/06/23.
//

import UIKit

class BaseViewController: UIViewController
{
    let baseViewModel = BaseViewModel()
    
    var label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setup_view()
        self.setup_label()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        
        self.baseViewModel.getLatestRates()
    }
    
    
    
    func setup_view()
    {
        self.view.backgroundColor = .white
        self.title = "Hello world!"
    }
    
    
    
    func setup_label()
    {
        let screenSize = UIScreen.main.bounds
        
        let label = UILabel(frame: CGRect(x: screenSize.width / 2 - 30,
                                          y: screenSize.height / 2,
                                          width: 100,
                                          height: 30))
        label.backgroundColor = .gray
        label.text = "Bye world...!"
        label.font = .boldSystemFont(ofSize: 16)
        self.view.addSubview(label)
        
        self.label = label
    }
}
