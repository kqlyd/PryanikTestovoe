//
//  ModuleBuilder.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 15.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import UIKit

protocol ModuleBuilderProtocol {
    static func CreateMainModule() -> UIViewController
}

class ModuleBuilder: ModuleBuilderProtocol {
    static func CreateMainModule() -> UIViewController{
        let view = MainModuleViewController()
        let networkService = NetworkService()
        let presenter = MainModulePresenter(view: view, network: networkService)
        view.presenter = presenter
        return view
    }
}
