//
//  ViewController.swift
//  Concentration
//
//  Created by Simon Ludwig
//  Copyright © 2018 Simon Ludwig. All rights reserved.
//

import UIKit
//controller
class ViewController: UIViewController {
    
    //classes get a free init as long as all vars are initialized
    lazy var game = Concentration(numberOfPairsOfCards: (allCardButtons.count + 1) / 2)
    //lazy means it doesnt initialize until someone tries to use it
    
    var flipCount = 0
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    @IBOutlet var allCardButtons: [UIButton]!
   
    
    @IBAction func cardTouched(_ sender: UIButton) {
        if let cardNumber = allCardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        game.flipCount += 1
        flipCountLabel.text = "Flip: \(game.flipCount)"
        if let cardNumber = allCardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            scoreCountLabel.text = "Score: \(game.scoreCount)"
            updateViewFromModel()
        }
        
    }
    @IBAction func restartGame(_ sender: UIButton) {
        game.flipCount = 0
        flipCountLabel.text = "Flips: 0"
        game.scoreCount = 0
        scoreCountLabel.text = "Score: 0"
        emojiArray += emojiDictionary.values
        emojiDictionary = [Int:String]()
        for index in allCardButtons.indices {
            let button = allCardButtons[index]
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.3976334333, alpha: 1)
            game.cards[index].isFaceUp = false
            game.cards[index].isMatch = false
            game.indexOfOnlyFaceUpCard = nil
        }
        updateViewFromModel()
    }
    
    func updateViewFromModel() {
        for index in allCardButtons.indices {
            let button = allCardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatch ? #colorLiteral(red: 0, green: 1, blue: 0.3976334333, alpha: 0) : #colorLiteral(red: 0, green: 1, blue: 0.3976334333, alpha: 1)
            }
            
        
        }
    }
    
    var emojiArray = ["⚽️","⚾️","🎾","🏈", "🏀", "🏉","🎱"]
    
    var emojiDictionary = [Int:String]()
    
    func emoji(for card: Card) -> String {
        //putting things in dictionary as theyre used
        if emojiDictionary[card.identifier] == nil, emojiArray.count > 0 {
            let randomIndex =
                Int(arc4random_uniform(UInt32(emojiArray.count)))
            emojiDictionary[card.identifier] = emojiArray.remove(at: randomIndex)
            
        }
        
        return emojiDictionary[card.identifier] ?? "?"
        //this is the same code as the line above:
        
        /*if emojiDictionary[card.identifier] != nil{
            return emojiDictionary[card.identifier]
        } else{
            return "?"
        }
        */
    }
    
    /*
    func cardFlip(withEmoji emoji: String, on button: UIButton){
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0, green: 1, blue: 0.3976334333, alpha: 1)
        }
        else {
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    NOT NEEDED ANYMORE B/C OF UPDATEVIEWFROMMODEL
   */
    
}

