//
//  NetworkService.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 15.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func getElements(completion: @escaping (Result<ElementsView?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol{
    func getElements(completion: @escaping (Result<ElementsView?, Error>) -> Void) {
        guard let url = URL(string: "https://pryaniky.com/static/json/sample.json") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do{
                let obj = try JSONDecoder().decode(ElementsView.self, from: data)
                completion(.success(obj))
            }
            catch{
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
