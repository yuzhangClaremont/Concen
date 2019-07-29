//
//  Card.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/31/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.
//

import Foundation

// card struct need to be accessed by others, mostly public
struct Card{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

// to generate identifier is internall (static for this type)
    private static var identifierFactory = 0

    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
