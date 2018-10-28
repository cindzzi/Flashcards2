//
//  ViewController.swift
//  Flashcards
//
//  Created by Adelia Manuel on 10/27/18.
//  Copyright © 2018 Adelia Manuel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var card: UIView!
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var BtnOptionTwo: UIButton!
    @IBOutlet weak var BtnOptionThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
        frontLabel.isHidden = false
    }
   
    func updateFlashcard(question: String, answer: String)  {
        
        dismiss(animated:true)
        
        
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
}

