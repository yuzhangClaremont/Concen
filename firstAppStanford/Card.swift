//
//  Card.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/31/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.
//

import Foundation

// difference between struct: 1.no inherantance 2.struct is value type, get copied when assigned, Class is reference type
struct Card{
     var isFaceUp = false
    var isMatched = false
    var identifier: Int
//    UI independent, so no emoji instance
    
    static var identifierFactory = 0
    // dont send to a Card object, global func, can send to a Card type???
    static func getUniqueIdentifier() -> Int{
        Card.identifierFactory += 1
        return Card.identifierFactory
    }
//    external name: identifier; internal name i(internal is must  )  init(identifier i:Int){
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
