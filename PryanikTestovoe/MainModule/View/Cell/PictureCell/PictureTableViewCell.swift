//
//  PictureTableViewCell.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 16.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import UIKit

class PictureTableViewCell: UITableViewCell, MainTableViewCellProtocol {
    func showAlert() -> UIAlertController {
        let message = "Picture message: " + (self.labelPicture.text ?? "No text picture")
        let alert = UIAlertController(title: "Picture cell", message: self.labelPicture.text, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var labelPicture: UILabel!
    @IBOutlet weak var imageViewPicture: UIImageView!
    
    var item: Elements?{
        didSet{
            switch item {
            case .picture(let picture):
                labelPicture.text = picture.text
                imageViewPicture.load(url: picture.url ?? "") {[weak self] in
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            default:
                break
            }
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: "PictureTableViewCell", bundle: nil)
    }
    
    override func prepareForReuse() {
        if imageViewPicture.image == nil{
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        } else {
            imageViewPicture.image = nil
        }
        labelPicture.text = "Picture Label"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = UIColor.red
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        //self.layer.borderWidth = 1
        if imageViewPicture.image == nil{
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        } else {
            activityIndicator.isHidden = true
            activityIndicator.stopAnimating()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
