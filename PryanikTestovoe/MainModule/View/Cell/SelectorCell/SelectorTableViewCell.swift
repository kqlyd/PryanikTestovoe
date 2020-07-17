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
    

    @IBOutlet weak var textFieldSelector: UITextField!

    var pickerViewSelector  = UIPickerView()
    
    
    
    var id: Int?
    var variantsSelector: [SelectorVariant]?
    var item: Elements?{
        didSet{
            switch item{
            case .selector(let selector):
                variantsSelector = selector.variants
            default:
                break
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureSelector()
        addButtonPickerView()
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
        textFieldSelector.text = variantsSelector?[row].text
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
        pickerViewSelector.dataSource = self
        pickerViewSelector.delegate = self
        textFieldSelector.inputView = pickerViewSelector
    }
    
    func addButtonPickerView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: super.contentView.frame.size.height/6, width: super.contentView.frame.size.width, height: 40.0))
        toolBar.layer.position = CGPoint(x: super.contentView.frame.size.width/2, y: super.contentView.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.black
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.donePressed))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: super.contentView.frame.size.width / 3, height: super.contentView.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = ""
        label.textAlignment = .center
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([flexSpace,textBtn,flexSpace,doneButton], animated: true)
        textFieldSelector.inputAccessoryView = toolBar
    }

    @objc func donePressed(sender: UIBarButtonItem) {
        let row = self.pickerViewSelector.selectedRow(inComponent: 0)
        id = variantsSelector?[row].id
        textFieldSelector.text = variantsSelector?[row].text
        textFieldSelector.resignFirstResponder()
    }
}
