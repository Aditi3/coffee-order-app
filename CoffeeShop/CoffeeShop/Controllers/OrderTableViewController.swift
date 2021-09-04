//
//  OrderTableViewController.swift
//  CoffeeShop
//
//  Created by Aditi Agrawal on 21/07/21.
//

import Foundation
import UIKit

class OrderTableViewController: UIViewController {
    
    var orderListViewModel = OrderListViewModel()
    @IBOutlet weak var ordersTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateOrders()
    }
    
    @IBAction func addCoffeeButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "segue_goToAddOrder", sender: self)
    }
    
    private func populateOrders() {
        
        WebService().load(resource: Order.all) { [weak self] result in
            
            switch result {
            case .success(let orders):
                self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                self?.ordersTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension OrderTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderListViewModel.ordersViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        let viewModel = self.orderListViewModel.orderViewModel(at: indexPath.row)
        cell.textLabel?.text = viewModel.name
        cell.detailTextLabel?.text = viewModel.size
        return cell
    }
    
}

