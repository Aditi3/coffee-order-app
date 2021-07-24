//
//  AddCoffeeOrderViewModel.swift
//  CoffeeShop
//
//  Created by Aditi Agrawal on 24/07/21.
//

import Foundation

struct AddCoffeeOrderViewModel {
   
    var name: String?
    var email: String?
    
    var types: [String] {
        return CoffeeType.allCases.map {$0.rawValue.capitalized}
    }
    
    var sizes: [String] {
        return CoffeeSize.allCases.map {$0.rawValue.capitalized}
    }
}
