//
//  PlayingCardDeck.swift
//  PlayingCard
//
//  Created by Yun Zhang on 7/31/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

import Foundation

struct PlayingCardDeck{
    private(set) var cards = [PlayingCard]()
    
    // draw a random card
    mutating func draw() -> PlayingCard? //struct func need to be mutating, return optional
    {
        if cards.count > 0
        {
            return cards.remove(at: cards.count.arc4random)
        }
        else
        {
            return nil
        }
    }
    
    init()
    {
        for suit in PlayingCard.Suit.all
        {
            for rank in PlayingCard.Rank.all
            {
                cards.append(PlayingCard(suit: suit, rank: rank))
            }
        }
    }
    
}


// EXTENSTION
extension Int
{
    var arc4random: Int
    {
        if self > 0
        {
            return Int( arc4random_uniform( UInt32(self) ) )
        }
        else if self < 0
        {
            return Int( arc4random_uniform ( UInt32( abs(self) ) ) )
        }
        else
        {
            return 0
        }
    }
}
