//
//  AnswerController.swift
//  Quiz App
//
//  Created by Igor Cunko on 2019-06-09.
//  Copyright © 2019 Cunko, Patrik. All rights reserved.
//

import UIKit

class AnswerController: UIViewController {

    @IBOutlet weak var result: UILabel!
    
    // creates variable to count your correct answers
    static var correctAnswers = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Raises the question number by 1
        GameScreenController.questionNumber += 1
        
        // resets all answers to unused
        for answer in GameScreenController.categories[GameScreenController.category]! {
            answer.answerUsed = false
        }
        /* if the previous statement in the answer buttons code is true then change the result label to correct and add 1 to correct answers otherwise the answer is wrong and change the label to show what the correct answer was */
        if (GameScreenController.isCorrectAnswer) {
            result.text = "Correct"
            AnswerController.correctAnswers += 1
        } else {
            result.text = "Wrong, correct answer was \(GameScreenController.currentAnswer)"
        }
        // ends the game by only showing the game over button and the arrow images after round 10
        if (GameScreenController.questionNumber >= 11) {
            gameOver.isHidden = false
            continueButton.isHidden = true
            result.isHidden = true
            downArrow.isHidden = false
        }
    }
    
    @IBOutlet weak var gameOver: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var downArrow: UIImageView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
