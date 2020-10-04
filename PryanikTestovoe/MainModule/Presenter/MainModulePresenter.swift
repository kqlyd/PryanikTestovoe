//
//  MainModulePresenter.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 15.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import Foundation


protocol MainModulePresenterProtocol: class {
    func getElements()
    var elementsView: ElementsView? { get set }
    var elemDict: [String: Elements] {get set}
}

protocol MainModuleViewProtocol: class {
    func setElements()
    func failure(error: Error)
}

class MainModulePresenter: MainModulePresenterProtocol {
    
    var network: NetworkServiceProtocol!
    weak var view: MainModuleViewProtocol!
    
    var elementsView: ElementsView?
    var elemDict = [String: Elements]()
    
    init(view: MainModuleViewProtocol, network: NetworkServiceProtocol) {
        self.view = view
        self.network = network
    }
    
    func getElements() {
        
        network.getElements { [weak self] (result) in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    self?.elementsView = data
                    self?.elementsView?.data?.forEach( {elem in
                        switch elem{
                        case .hz( _):
                            self?.elemDict["hz"] = elem
                        case .picture( _):
                            self?.elemDict["picture"] = elem
                        case .selector( _):
                            self?.elemDict["selector"] = elem
                        case .unknown:
                            print("unk")
                        }
                    })
                    self?.view.setElements()
                }
            case .failure(let error):
                self?.view.failure(error: error)
            }
        }
    }
}
