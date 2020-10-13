//
//  GameScreenController.swift
//  Quiz App
//
//  Created by Cunko, Patrik on 2019-05-14.
//  Copyright © 2019 Cunko, Patrik. All rights reserved.
//

import UIKit

class GameScreenController: UIViewController {
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    @IBOutlet weak var questionNumberLabel: UILabel!
    
    // Array of class instances that contain World Capital questions and answers
    static var worldQuestions: [CategoryGroup] = [CategoryGroup(question: "What is the capital of Bosnia & Herzegovina", answer: "Sarajevo"), CategoryGroup(question: "What is the capital of Portugal", answer: "Lisbon"), CategoryGroup(question: "What is the capital of Algeria", answer: "Algiers"), CategoryGroup(question: "What is the capital of Mexico", answer: "Mexico City"), CategoryGroup(question: "What is the capital of Ecuador", answer: "Quito"), CategoryGroup(question: "What is the capital of Croatia", answer: "Zagreb"), CategoryGroup(question: "What is the capital of Spain", answer: "Madrid"), CategoryGroup(question: "What is the capital of Russia", answer: "Moscow"), CategoryGroup(question: "What is the capital of Peru", answer: "Lima"), CategoryGroup(question: "What is the capital of Hungary", answer: "Budapest"), CategoryGroup(question: "What is the capital of Turkey", answer: "Ankara")]
    
    // Array of class instances that contain Math questions and answers
    static var mathQuestions: [CategoryGroup] = [CategoryGroup(question: "(2 + 7) / 3", answer: "3"), CategoryGroup(question: "(3 * 3 + 3) / 2", answer: "6"), CategoryGroup(question: "2x/4 = 4 What does x = ?", answer: "8"), CategoryGroup(question: "x^2 = 100 What does x = ?", answer: "10"), CategoryGroup(question: "(5 * 6) / 2", answer: "15"), CategoryGroup(question: "3 + 4", answer: "7"), CategoryGroup(question: "35 * 2", answer: "70"), CategoryGroup(question: "52 + 42", answer: "94"), CategoryGroup(question: "8 * 7", answer: "56"), CategoryGroup(question: "36 * 3", answer: "108")]
    
    // Dictionary that applies a category to and group of questions
    static var categories :[String:[CategoryGroup]] = ["World Capitals" : worldQuestions , "Math" : mathQuestions ]
    
    // Created variables to be used in other parts of the code
    static var questionToBeUsed  = ""
    static var currentAnswer = ""
    static var questionNumber = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Shows question number in label
        questionNumberLabel.text = "Question #" + String(GameScreenController.questionNumber)
        
        /* Picks the array of questions and answers to be used depending on the selected category */
        var selectedQuestions = GameScreenController.categories[GameScreenController.category]
        // makes variable the size of the array count and converts it to type UInt32
        let length = UInt32(selectedQuestions!.count)
        // creates variable for to pick a random question
        var randomQuestion = 0
        // Selects which question and answer will be used
        var groupToBeUsed = selectedQuestions![randomQuestion]
        /* makes a random number the size of the selected array and converts it to type Int and picks the question and answer at that position in the array, this repeats until it finds a question that has not yet been used*/
        repeat {
            randomQuestion = Int(arc4random_uniform(length))
            groupToBeUsed = selectedQuestions![randomQuestion]
        } while (groupToBeUsed.alreadyUsed == true)
        
        /* If the question and answer found is not yet used it selects them and then marks them as used */
        if (groupToBeUsed.alreadyUsed == false ) {
            GameScreenController.questionToBeUsed = groupToBeUsed.question
            groupToBeUsed.alreadyUsed = true
            groupToBeUsed.answerUsed = true
            
            /* makes an array that will contain 4 answers to appear on screen and puts the correct answer in by default */
            var answers: [String] = [groupToBeUsed.answer]
            GameScreenController.currentAnswer = groupToBeUsed.answer
            
            // Selects 3 other unused answers and then marks them as used
            while (answers.count < 4) {
                let randomAnswer = Int(arc4random_uniform(length))
                if (selectedQuestions![randomAnswer].answerUsed == false) {
                    answers.append(selectedQuestions![randomAnswer].answer)
                    selectedQuestions![randomAnswer].answerUsed = true
                }
            }
            
            /* Picks a random answer from the answer array and then swithces it's position with the correct answer so that the location of the correct answer isn't always the same */
            let randomAnswer = Int(arc4random_uniform(UInt32(answers.count)))
            let otherRandom = answers[randomAnswer]
            answers[randomAnswer] = answers[0]
            answers[0] = otherRandom
            
            // Changes the titles for the answer buttons to the 4 selected answers
            answer1.setTitle(answers[0], for: .normal)
            answer2.setTitle(answers[1], for: .normal)
            answer3.setTitle(answers[2], for: .normal)
            answer4.setTitle(answers[3], for: .normal)
            
            // Changes the question label text to the selected question
            questionLabel.text = GameScreenController.questionToBeUsed
        }
    }
    
    // Default category
    static var category = "World Capitals"
    
    /* Class that is used to group a category of questions and contains 4 variables, a question, answer and whether it is already used or not */
    class CategoryGroup {
        var question: String
        var answer: String
        var alreadyUsed = false
        var answerUsed = false
        
        init(question:String, answer:String){
            self.question = question
            self.answer = answer
        }
    }
    // makes a boolean value equal true
    static var isCorrectAnswer = true
    
    // Checks if the button title is equal to the picked answer
    @IBAction func answerOneButton(_ sender: Any) {
        GameScreenController.isCorrectAnswer = (answer1.currentTitle == GameScreenController.currentAnswer)
    }
    
    @IBAction func answerTwoButton(_ sender: Any) {
        GameScreenController.isCorrectAnswer = (answer2.currentTitle == GameScreenController.currentAnswer)
    }
    
    @IBAction func answerThreeButton(_ sender: Any) {
        GameScreenController.isCorrectAnswer = (answer3.currentTitle == GameScreenController.currentAnswer)
    }
    
    @IBAction func answerFourButton(_ sender: Any) {
        GameScreenController.isCorrectAnswer = (answer4.currentTitle == GameScreenController.currentAnswer)
    }
    
    // Goes back to start screen and resets the answers to all unused
    @IBAction func Exit(_ sender: Any) {
        for answer in GameScreenController.categories[GameScreenController.category]! {
            answer.answerUsed = false
        }
    }
    
}
