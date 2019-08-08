 //
//  PlayingCard.swift
//  PlayingCard
//
//  Created by Yun Zhang on 7/31/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

import Foundation
 
 // a protocal to be used for print
 struct PlayingCard: CustomStringConvertible{
    var description: String{
        // print suit and rank instead of object
        return "\(self.suit) : \(self.rank)"
    }
    
    var suit: Suit
    var rank: Rank
 
    // set enum type as Int, automatically set cases associate with int
    enum Suit: String, CustomStringConvertible{
        var description: String{
            return rawValue // print value, instead of "spades"
        }
        
//        case spades // = 0, "spades" if raw value is String
//        case hearts // = 1
//        case clubs
//        case diamonds
        
        case spades = "♠️"
        case diamonds = "♦️"
        case hearts = "♥️"
        case clubs = "♣️"
        
        static var all = [Suit.spades, Suit.hearts, Suit.diamonds, Suit.clubs]
    }
//    enum Suit: String{
//        var rawValue: PlayingCard.Suit.RawValue
//
//    }
    enum Rank: CustomStringConvertible
    {
        var description: String{
            switch self{
            case .ace: return "A"
            case .numeric(let pips): return String(pips)
            case .face(let kind): return kind
            }
        }
        
        case ace
        case face(String) // J,Q,K
        case numeric(Int)
        
        // computed property
        var order: Int
        {
            switch self
            {
            case .ace:
                return 1
            case .numeric(let pips): // NUMERIC is int, pips is numb of the graphes on card
                return pips // pips is the associated value
            case .face(let kind) where kind == "J": // kind is the associated value
                return 11   // where is pattern matching, subset of kind
            case .face(let kind) where kind == "Q":
                return 12
            case .face(let kind) where kind == "K":
                return 13
            default: // must be exaust
                return 0
            }
        }
        // an array of all ranks (static variable for this type Rank*?)
        static var all: [Rank]
        {   // build a list of enum with default initializer*?
            var allRanks: [Rank] = [Rank.ace]
            for pips in 2...10
            {
                allRanks.append(Rank.numeric(pips))
            }
            
            allRanks += [Rank.face("J"), .face("Q"), .face("K")]
            
            return allRanks
        }
    }
 
 }
