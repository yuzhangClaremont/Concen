//
//  ConcentrationModel.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/31/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.

// Xcode: cmd+arrows to turn the ui

import Foundation
// no need to pass game around, so concentration is struct
struct Concentration{

    // UI update will look into cards, so public to get but not set
    private(set) var cards = [Card]()//empty array to init
   // but index of unique up is private
    private var indexOfOneAndOnlyFaceUpCard: Int?
    {
        get{
            var foundIndex: Int?
            for index in cards.indices{
//                print(index)
//                print(self.indexOfOneAndOnlyFaceUpCard)
                if cards[index].isFaceUp{
                    if foundIndex == nil{
                        foundIndex = index
                    }else{
                        return nil
                    }
                }
            }
            return foundIndex
        }

        set{
            // when indexOf... changed value, turn all cards down, except the card with index theOnlyFaceUp
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
 
    // controller will choose card, so public
    mutating func chooseCard(at index: Int){
    // use assert to prevent input is -1
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): choosen index not in the card")
        print("this card \(cards[index].isFaceUp)")

        if cards[index].isFaceUp{
            cards[index].isFaceUp = false
            //Cannot assign to property: 'self' is immutable
        }else{
            cards[index].isFaceUp = true
        }
        print("index is \(index), face up is\(cards[index].isFaceUp )")
        if !cards[index].isMatched{
            // use getter here, if indexOfOne.. not nil, set to nil
            
            if let matchIndex = indexOfOneAndOnlyFaceUpCard{
//                print(indexOfOneAndOnlyFaceUpCard)
                if matchIndex != index{
                if cards[matchIndex] == cards[index]{
                    cards[matchIndex].isMatched=true
                    cards[index].isMatched=true
                }
            
                print("choose index \(index)")
                print("this card is face up? \(cards[index].isFaceUp )")
                cards[index].isFaceUp = true
//                indexOfOneAndOnlyFaceUpCard = nil
                    
                }
            }else{
//                for flipDownIndex in cards.indices{
//                    cards[flipDownIndex].isFaceUp = false
//                }
//                    cards[index].isFaceUp = true
                
                // use setter here
                    indexOfOneAndOnlyFaceUpCard = index
            }
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
