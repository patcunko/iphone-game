//
//  CategoriesController.swift
//  Quiz App
//
//  Created by Cunko, Patrik on 2019-05-15.
//  Copyright © 2019 Cunko, Patrik. All rights reserved.
//

import UIKit

class CategoriesController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // selects a category
    @IBAction func worldCapitals(_ sender: Any) {
        GameScreenController.category = "World Capitals"
    }
    
    @IBAction func math(_ sender: Any) {
        GameScreenController.category = "Math"
    }
   
    
   
}
