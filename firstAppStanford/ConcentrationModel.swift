//
//  ConcentrationModel.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/31/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.
//

import Foundation

class Concentration{
    
    var cards = Array<Card>()//empty array to init
    
    func chooseCard(at index: Int){
        
    }
    
    init(numberOfPairesOfCards: Int){
//        for loop can be run in all sequences like array, string, or countable range
        for _ in 0..<numberOfPairesOfCards{
            //        struct defualt initializer is parametized
            let card = Card()
            let matchingCard = card //card is a struct, assigning copies it
            cards += [card]
            cards.append(matchingCard)// the third copy, 4 cards
        }

    }
    
}
