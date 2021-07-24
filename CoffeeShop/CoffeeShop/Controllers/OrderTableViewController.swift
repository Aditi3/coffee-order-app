//
//  OrderTableViewController.swift
//  CoffeeShop
//
//  Created by Aditi Agrawal on 21/07/21.
//

import Foundation
import UIKit

class OrderTableViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addCoffeeButtonTapped(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: "segue_goToAddOrder", sender: self)
    }
    
    private func populateOrders() {
        
        guard let coffeeOrderUrl = URL(string: "https://guarded-retreat-82533.herokuapp.com/orders") else {
            fatalError("Url was incorrect")
        }
        
        let resource = Resource<[Order]>(url: coffeeOrderUrl)
        
        WebService().load(resource: resource) { result in
            
            switch result {
            case .success(let orders):
                print(orders)
            case .failure(let error):
                print(error)
            }
        }
    }
}


extension OrderTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coffeeCell", for: indexPath)
        return cell
    }
    
    
}
extension OrderTableViewController: UITableViewDelegate {
    
}
