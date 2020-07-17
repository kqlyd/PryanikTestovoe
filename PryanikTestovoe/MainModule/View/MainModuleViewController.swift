//
//  MainModuleViewController.swift
//  PryanikTestovoe
//
//  Created by Denis Zhukov on 15.07.2020.
//  Copyright © 2020 Denis Zhukov. All rights reserved.
//


import UIKit

protocol MainTableViewCellProtocol: UITableViewCell {
    var item: Elements? { get set }
    func showAlert()
}

class MainModuleViewController: UIViewController {
    
    var presenter: MainModulePresenterProtocol!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter.getElements()
    }
    
    func configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView?.register(SelectorTableViewCell.nib, forCellReuseIdentifier: "SelectorTableViewCell")
        tableView?.register(HzTableViewCell.nib, forCellReuseIdentifier: "HzTableViewCell")
        tableView?.register(PictureTableViewCell.nib, forCellReuseIdentifier: "PictureTableViewCell")
    }
}

extension MainModuleViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCellProtocol
        cell?.showAlert()
    }
}

extension MainModuleViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter.elementsView?.view?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let typeElement = ElementType(rawValue: self.presenter.elementsView?.view?[indexPath.row] ?? "unknown")
        
        
        switch typeElement {
        case .hz:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HzTableViewCell", for: indexPath) as? HzTableViewCell{
                cell.item = self.presenter.elemDict[typeElement!.rawValue]
                return cell
            }

        case .picture:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "PictureTableViewCell", for: indexPath) as? PictureTableViewCell{
                cell.item = self.presenter.elemDict[typeElement!.rawValue]
                return cell
            }

        case .selector:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SelectorTableViewCell", for: indexPath) as? SelectorTableViewCell{
                cell.item = self.presenter.elemDict[typeElement!.rawValue]
                return cell
            }

        case .unknown:
            cell.textLabel?.text = "unknown cell"
        case .none:
            cell.textLabel?.text = "none cell"
        }
        return cell
    }
    
    
}

extension MainModuleViewController: MainModuleViewProtocol{
    func setElements() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    func failure(error: Error) {
        print(error)
    }
}

