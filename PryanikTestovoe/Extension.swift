//
//  Extension.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 16.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: String, completion: @escaping()->()) {
        guard let url = URL(string: url) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        completion()
                    }
                }
            }
        }
    }
}
