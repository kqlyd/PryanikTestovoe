//
//  MainModuleView.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 15.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    var presenter: MainModulePresenterProtocol!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
    }
    
}

extension MainViewController: MainModuleViewProtocol{
    func setElements() {
        
    }
    
    func failure(error: Error) {
        
    }
    
    
}
