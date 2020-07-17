//
//  HzTableViewCell.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 16.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import UIKit

class HzTableViewCell: UITableViewCell, MainTableViewCellProtocol {
    func showAlert() {
        print("Text Hz: ", self.hzTextLabel.text ?? "")
    }
    

    @IBOutlet weak var hzTextLabel: UILabel!

    var item: Elements?{
        didSet{
            switch item{
            case .hz(let hz):
                hzTextLabel.text = hz.text
            default:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib:UINib {
        return UINib(nibName: "HzTableViewCell", bundle: nil)
    }
    
    
}
