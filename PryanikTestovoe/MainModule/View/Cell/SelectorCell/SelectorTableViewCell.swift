//
//  SelectorTableViewCell.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 16.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//

import UIKit

class SelectorTableViewCell: UITableViewCell, MainTableViewCellProtocol {
    func showAlert() -> UIAlertController {
        let message = "Id selector: " + (id?.description ?? "Selector not choose")
        let alert = UIAlertController(title: "Selector cell", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        return alert
    }
    

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var chooseLabel: UILabel!
    
    var id: Int?
    var selectedId: Int?
    var variantsSelector: [SelectorVariant]?
    var item: Elements?{
        didSet{
            switch item{
            case .selector(let selector):
                selectedId = selector.selectedId
                variantsSelector = selector.variants
                chooseLabel.text = variantsSelector?[selectedId ?? 0].text
                pickerView.selectRow(self.selectedId ?? 0, inComponent: 0, animated: true)
            default:
                break
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.backgroundColor = UIColor.red
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        //self.layer.borderWidth = 1
        configureSelector()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib:UINib {
        return UINib(nibName: "SelectorTableViewCell", bundle: nil)
    }
    
}

extension SelectorTableViewCell: UIPickerViewDelegate{
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = variantsSelector?[row].text
           return row
       }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        id = variantsSelector?[row].id
        chooseLabel.text = variantsSelector?[row].text
    }
}

extension SelectorTableViewCell: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return variantsSelector?.count ?? 0
    }
}

extension SelectorTableViewCell{
    
    func configureSelector(){
        pickerView.dataSource = self
        pickerView.delegate = self
    }
}
