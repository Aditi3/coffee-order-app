//
//  AddOrderViewController.swift
//  CoffeeShop
//
//  Created by Aditi Agrawal on 21/07/21.
//

import Foundation
import UIKit

protocol AddCoffeeOrderDelegate {
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController)
    func addCoffeeOrderViewControllerDidClose(controller: UIViewController)
}

class AddOrderViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var coffeeListTableview: UITableView!
    private var coffeeSizesSegmentedControl: UISegmentedControl!
    private var viewModel = AddCoffeeOrderViewModel()
    var delegate: AddCoffeeOrderDelegate?
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        emailTextField.delegate = self
        setupUI()
    }
    
    
    // MARK: - Set up UI
    
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
    
    
    // MARK: - Actions
    
    @IBAction func close() {
        if let delegate = self.delegate {
            delegate.addCoffeeOrderViewControllerDidClose(controller: self)
        }
    }
    
    @IBAction func save() {
        
        let name = self.nameTextField.text
        let email = self.emailTextField.text
        
        let selectedSize = self.coffeeSizesSegmentedControl.titleForSegment(at: self.coffeeSizesSegmentedControl.selectedSegmentIndex)
        
        guard let indexPath = self.coffeeListTableview.indexPathForSelectedRow else {
            fatalError("Error in selecting coffee!")
        }
        
        self.viewModel.name = name
        self.viewModel.email = email
        self.viewModel.selectedSize = selectedSize
        self.viewModel.selectedType = self.viewModel.types[indexPath.row]
        
        WebService().load(resource: Order.create(vm: self.viewModel)) { result in
            switch result {
            case .success(let order):
                if let order = order, let delegate = self.delegate {
                    delegate.addCoffeeOrderViewControllerDidSave(order: order, controller: self)
                }
                print(order ?? "")
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension AddOrderViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
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
