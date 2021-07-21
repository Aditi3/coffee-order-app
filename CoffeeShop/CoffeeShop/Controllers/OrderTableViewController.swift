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
    
}
