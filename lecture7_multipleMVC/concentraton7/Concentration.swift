//
//  ConcentrationModel.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/31/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.

import Foundation
// no need to pass game around, so concentration is struct
struct Concentration{

    // UI update will look into cards, so public to get but not set
    private(set) var cards = [Card]()//empty array to init
   // but index of unique up is private
    private var indexOfOneAndOnlyFaceUpCard: Int?
    { // computed property
        get{
            // array of indices if face up. Map, filter, closure
            return cards.indices.filter({cards[$0].isFaceUp}).oneAndOnly
        }
        set{
            // when indexOf... changed value to newValue, turn all cards down, except the card with index theOnlyFaceUp
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
 
    // controller will choose card, so public
    mutating func chooseCard(at index: Int){
    // use assert to prevent input is -1
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): choosen index not in the card")
        
// if this card is not matched
        if !cards[index].isMatched{
            
 // when the onlyfaceUpCard exist, and touch differnt card from the onlyfaceUpCard // use getter here
            if let matchIndex = indexOfOneAndOnlyFaceUpCard{
// when touching card different from theFaceUP
                if matchIndex != index{
// when they match, make match
                    if cards[matchIndex] == cards[index]{
                        cards[matchIndex].isMatched=true
                        cards[index].isMatched=true
                    }
// MAKE ALL TOUCHED CARD FACE UP
                cards[index].isFaceUp = true
                }else{ // when touching the only faceUp
                    print("you touched the only face up card")
                }
            }
// when no face up or 2 face up, that is indexOfOneAndOnlyFaceUpCard == nil
            else{          // use setter here, make this touched card the onlyFaceUp
                indexOfOneAndOnlyFaceUpCard = index
            }
        }else{
            print("you touched the matched card")
            }
    }
    
    // initializer need to be public otherwise no one can create game
    init(numberOfPairesOfCards: Int){
        // use assert to prevent input is -1
        assert(numberOfPairesOfCards > 0, "Concentration.chooseCard(at: \(numberOfPairesOfCards): must have postive number of pairs")
        for _ in 1...numberOfPairesOfCards{
            let card = Card()
            cards += [card, card] // copies too
        }
    }
    
}
extension Collection
    // text is also a collection, first is a property
{
    var oneAndOnly: Element?
    {
        return count == 1 ? first : nil
    }
}
