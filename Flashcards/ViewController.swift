//
//  ViewController.swift
//  Flashcards
//
//  Created by Adelia Manuel on 10/27/18.
//  Copyright © 2018 Adelia Manuel. All rights reserved.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var BtnOptionTwo: UIButton!
    @IBOutlet weak var BtnOptionThree: UIButton!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIButton!
    
    //Array to hold our flashcards.
    var flashcards = [Flashcard]()
    
    //Current flashcard index.
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readSavedFlashcards()
        if flashcards.count == 0 {
        updateFlashcard(question: "What's the capital of Brazil?", answer: "Brasilia")
        } else {updateLabels()
            updateNextPrevButtons()
        }
        
    card.layer.cornerRadius = 20.0
        card.clipsToBounds = true
        card.layer.shadowRadius = 15.0
        card.layer.shadowOpacity = 0.2
        frontLabel.layer.cornerRadius = 30.0
        frontLabel.clipsToBounds = true
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        BtnOptionTwo.layer.borderWidth = 3.0
        BtnOptionTwo.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        BtnOptionThree.layer.borderWidth = 3.0
        BtnOptionThree.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    @IBAction func DidTapOnFlashcards(_ sender: Any) {
        if frontLabel.isHidden == true { frontLabel.isHidden = false}
        else {
            frontLabel.isHidden = true
        }
        flipFlashcard()
    }
    func flipFlashcard(){
        if frontLabel.isHidden == true { frontLabel.isHidden = false}
        else {
            frontLabel.isHidden = true
        }
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden = true
        })
    }
    func updateLabels(){
        //get current flashcard
        let currentFlashcard = flashcards[currentIndex]
        //update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    func updateFlashcard(question: String, answer: String)  {
        
        let flashcard=Flashcard(question: question, answer: answer)
       
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
       
        flashcards.append(flashcard)
        
        //logging to the console
        print ("😎 Added new flashcard ")
        print("😎 We now have \(flashcards.count) flashcards")
        // Update current index
        currentIndex = flashcards.count - 1
        print("😎 Our current index is \(currentIndex)")
        
        // update buttons
        updateNextPrevButtons()
        
        //update labels
        updateLabels()
       
    }
    func updateNextPrevButtons(){
        //Disable next button if at the end
        if currentIndex == flashcards.count - 1{
        nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
        // Disable prev button if at the beginning
    }
    
    func saveAllFlashcardsToDisk(){
        
        
        // from flashcard array to dictionary array
        let dictionaryArray = flashcards.map {(card) -> [String: String] in return ["question": card.question, "answer": card.answer]
        }
            //save array on disk using userDefaults
            UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        //log in
        print("🎉 Flashcards saved to Userdefaults")
    }
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]
    {        let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary ["question"]!, answer: dictionary ["answer"]!)
            
        }
        flashcards.append(contentsOf: savedCards)
        }
    }
    
    @IBAction func DidTapOptionOne(_ sender: Any) {
    btnOptionOne.isHidden = true
    }
    
    @IBAction func DidTapOptionTwo(_ sender: Any) {
    frontLabel.isHidden = true
    }
    
    @IBAction func DidTapOptionThree(_ sender: Any) {
    BtnOptionThree.isHidden = true
    }
    
    @IBAction func DipTapOnNext(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex + 1
        // update labels
        updateLabels()
        
        //uddate buttons
        updateNextPrevButtons()
        
        animateCardOut()
    }
    
    @IBAction func DipTapOnPrev(_ sender: Any) {
        // Increase current index
        currentIndex = currentIndex - 1
        // update labels
        updateLabels()
        
        //uddate buttons
        updateNextPrevButtons()
        //animateCardIn()
    }
    
    func animateCardOut() {
        UIView.animate(withDuration: 0.3, animations: {self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)}, completion: { finished in
            
            self.updateLabels()
            
            self.animateCardIn()
        })
    }
    
    func animateCardIn() {
        card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3) {
            self.card.transform = CGAffineTransform.identity
            
        }
    }
}

