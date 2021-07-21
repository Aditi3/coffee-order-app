//
//  AddOrderViewController.swift
//  CoffeeShop
//
//  Created by Aditi Agrawal on 21/07/21.
//

import Foundation
import UIKit

class AddOrderViewController: UIViewController {
    
    @IBOutlet var segmentControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        
        // remove all current segments to make sure it is empty:
        segmentControl.removeAllSegments()
        
        // adding your segments
        segmentControl.insertSegment(withTitle: "Small", at: 0, animated: false)
        segmentControl.insertSegment(withTitle: "Medium", at: 1, animated: false)
        segmentControl.insertSegment(withTitle: "Large", at: 2, animated: false)
        
    }
}
