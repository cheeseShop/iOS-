//
//  Concetration.swift
//  Concentration
//
//  Created by Simon Ludwig
//  Copyright © 2018 Simon Ludwig. All rights reserved.
//

import Foundation
//model
class Concentration{
    
    //creating an instance of a struct/class
    var cards = [Card]()
    var flipCount = 0
    var scoreCount = 0
    var alreadyChosen = [Int]()
    

    //in cases where there isnt one and only face up card this will be not set
    //when there is one face up card this will tell you the index to match against it
    //when this is nil you wont have to do any matching
    var indexOfOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatch {
            if let matchIndex = indexOfOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatch = true
                    cards[index].isMatch = true
                    scoreCount += 2
                } else {
                    for chosenMarker in alreadyChosen.indices {
                        if cards[index].identifier == alreadyChosen[chosenMarker] || cards[matchIndex].identifier == alreadyChosen[chosenMarker] {
                            scoreCount -= 1
                        }
                    }
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOnlyFaceUpCard = index
            }
            
        }
    
    }
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        for _ in 1...cards.count {
            let randomIndex = Int (arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(0, randomIndex)
        }
    }
   
}
