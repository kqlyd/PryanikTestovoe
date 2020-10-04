//
//  HzTableViewCell.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 16.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import UIKit

class HzTableViewCell: UITableViewCell, MainTableViewCellProtocol {
    func showAlert() -> UIAlertController {
        let message = "Text: " + (self.hzTextLabel.text ?? "No text")
        let alert = UIAlertController(title: "Hz cell", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
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
        //self.backgroundColor = UIColor.p
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        //self.layer.borderWidth = 1
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib:UINib {
        return UINib(nibName: "HzTableViewCell", bundle: nil)
    }
    
    
}
