//
//  ConcentrationModel.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/31/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.
//

import Foundation //https://developer.apple.com/documentation/foundation


//  This
class Concentration{
    
    var cards = [Card]()//empty array to init
    var indexOfOneAndOnlyFaceUpCard: Int? //optional, nil when no card face up or two card face up. Init with nil
    var matchCount = 0
    
    func chooseCard(at index: Int){
        
        // For debugging
        print("cards lenth is \(cards.count)")
        print("index is \(index)")
        
        // Resetting Card Facing State
        if cards[index].isFaceUp{
            cards[index].isFaceUp = false
        }else{
            cards[index].isFaceUp = true
        }
        
        // when cards are not matched
        if !cards[index].isMatched{
            // when indexOfOneAndOnlyFaceUpCard not nil(one card up), and the unique up card not the card I chose.
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
                // if the card i chose has same id with the unique up facing card, the two card matched
                if cards[matchIndex].identifier == cards[index].identifier{
                    cards[matchIndex].isMatched=true
                    cards[index].isMatched=true
                    matchCount += 2
                }
                // match or not, we show these two cards, and no card is uniquly up
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }else{
                // if no card or two cards up, touch card turn every card down,
                // except the card you touched, make it unique
                for flipDownIndex in cards.indices{
                    cards[flipDownIndex].isFaceUp = false
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = index
                }
            }
        }
        // when card matched, do nothing, just increment flips
    }
    
    // init constructor usually have same internal and externally name
    init(numberOfPairesOfCards: Int){
    // for loop can be run in all sequences like array, string, or countable range (in this case)
        for _ in 0..<numberOfPairesOfCards{
            //  struct defualt initializer is parametized
            let card = Card()
//            let matchingCard = card //card is a struct, assigning copies it, so two card has same identifier
            cards += [card, card] // copies too
//            cards.append(matchingCard)// same as last line, append also copy the card, deep copy copy memoery https://stackoverflow.com/questions/184710/what-is-the-difference-between-a-deep-copy-and-a-shallow-copy
            // TODO: shuffle the card
        }

    }
    
}
