//
//  Card.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/31/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.
//

import Foundation

// difference between struct: 1.no inherantance 2.struct is value type (Int, Array, Dictory),  get copied when assigned. Class is reference type, when assigned, pass the pointer

// card is UI independent, so no emoji on it. specify how the card behave
struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int // used to match card
//    UI independent, so no emoji instance
    
    static var identifierFactory = 0
    // static func: only available in the class. type card understand the method? can not be overwritten by child class
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
//  struct free structor differ from class
// a card does not need to specify an identifier as long as  it is unique
    init(){
        // self to refer properties
        // Static member 'getUniqueIdentifier' cannot be used on instance of type 'Card'?
        self.identifier = Card.getUniqueIdentifier()
    }
}
