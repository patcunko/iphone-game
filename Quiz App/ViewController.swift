//
//  ViewController.swift
//  Quiz App
//
//  Created by Cunko, Patrik on 2019-05-09.
//  Copyright © 2019 Cunko, Patrik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
        
        /* This part resets the questions to not used so they are all available again */
        for question in GameScreenController.categories[GameScreenController.category]! {
            question.alreadyUsed = false
        }
        
        // Changes labels to show last game score and selected category
        if (AnswerController.correctAnswers == 0 && GameScreenController.questionNumber == 1){
            pointLabel.text = "Play A Game To See!"
        } else {
        pointLabel.text = "\(AnswerController.correctAnswers) / \(GameScreenController.questionNumber - 1)"
        }
        categoryLabel.text = "Selected Catergory is " + GameScreenController.category
    }
   
    // Resets question number and your correct answers
    @IBAction func start(_ sender: Any) {
         GameScreenController.questionNumber = 1
         AnswerController.correctAnswers = 0
    }
    
}

