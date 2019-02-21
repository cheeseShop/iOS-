//
//  Card.swift
//  Concentration
//
//  Created by Simon Ludwig 
//  Copyright © 2018 Simon Ludwig. All rights reserved.
//

import Foundation

//struct not a class b/c structs are value types (classes are reference types) and have no inheritance
struct Card {
    var isFaceUp = false
    var isMatch = false
    var identifier: Int
    //no need for emoji b/c this is UI-independent
    
    //utility function that is tied to the type
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    static var identifierFactory = 0
    
    
    //inits usually have the same internal/external names
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
