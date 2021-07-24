//
//  AddOrderViewController.swift
//  CoffeeShop
//
//  Created by Aditi Agrawal on 21/07/21.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var coffeeListTableview: UITableView!
    private var viewModel = AddCoffeeOrderViewModel()
    private var coffeeSizesSegmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
   
    private func setupUI() {
        self.coffeeListTableview.tableFooterView = UIView()
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        self.coffeeSizesSegmentedControl = UISegmentedControl(items: self.viewModel.sizes)
        
        self.coffeeSizesSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.coffeeSizesSegmentedControl)
        
        self.coffeeSizesSegmentedControl.topAnchor.constraint(equalTo: self.coffeeListTableview.bottomAnchor, constant: 20).isActive = true
        self.coffeeSizesSegmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}

extension AddOrderViewController: UITextFieldDelegate {
    
    
}

extension AddOrderViewController: UITableViewDataSource, UITableViewDelegate {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.types.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoffeeTypeTableViewCell", for: indexPath)
        cell.textLabel?.text = self.viewModel.types[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
