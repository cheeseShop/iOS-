//
//  ViewController.swift
//  Practice Project 2
//
//  Created by Simon Ludwig on 2/13/19.
//  Copyright © 2019 Simon Ludwig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    //array of strings to hold all countries
    var countries = [String]()
    //correctAnswer will store whether flag 0,1,2 holds the correct answer
    var correctAnswer = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //in order to deal with flags that have white in them not blending with the white background
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        //changing the border to gray - need to add cgColor to the end of UIColor to have it convert to a CGColor
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        
        askQuestion(action: nil)
        //(action: nil) added in call means "there is no UIAlertAction for this"
        
    }
    
    //added (action: UIAlertAction!) to make ac.addAction on line 78 work
    func askQuestion(action: UIAlertAction!) {
        //randomize the order of the countries in the array
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        //button1.setImage() assigns a UIImage to the button - will change when askQuestion is called
        //for: .normal - specifies which state of the button should be changed - .normal means "the standard state of the button"
        
        
        //chosing a random number for the correct answer
        correctAnswer = Int.random(in: 0...2)
        
        //to make the title look nicer
        title = countries[correctAnswer].uppercased()
    }
    
    //@IBAction is how to make storyboard layouts trigger code
    //this method needs to check whether the answer is right, adjust the player score up/down, show a message telling them the new score
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        var title: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            title = "Wrong"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        //.alert pops up a message over the center of the screen
        
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        //using the UIAlertAction data type to add a button that says to continue
        //handler is looking for a closure(code to run when button tapped) - use askQuestion not askQuestion() because we want the game to continue
        
        present(ac, animated: true)
        //two parameters are a view controller to present and whether to animate
        
        
    }
    

}

