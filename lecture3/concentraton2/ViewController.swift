//
//  ViewController.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/30/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.

// lecture 3 make stacks, main storyboard right bot to embed in stack. circle all buttons to find a stack, alignment fill eqully

// pin to edges, circle the stack, ctrl drag to top, top space to safe area. left, leading space to safe. pin to the right with same space as left (16). alignment fill eqully

// pin flip label to bottom, pin to center horizontally

// click view controller secen in main storyboard, update constrans

// constrain greater than or equal to make sure buttons above flips

import UIKit // top cocoa layer

class ViewController: UIViewController {


    @IBOutlet private var cardsButtons: [UIButton]!
    
// get only property, so private by nature
    var pairNumber: Int{
        return (cardsButtons.count+1) / 2
    }
    
// game is a model, can be public, tied to UI(which tied to viewController), therefore set as private
    private lazy var game = Concentration(numberOfPairesOfCards: pairNumber)
    

// don't want other class to set flipCount
   private(set) var flipCount: Int = 0 {

            didSet{
                flipCountLabel.text = "Flip: \(flipCount)"
            }
        }

// UI Outlet, actions, need to be private
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
//        print((cardsButtons.count+1) / 2)
        flipCount += 1

        if let cardNumber = cardsButtons.index(of: sender) {
            print("cardnumber, \(cardNumber)")

            game.chooseCard(at: cardNumber)
            print("card \(cardNumber) ")
            updateViewFromModel()
            
        }else{
            print("chosen card not in card button")
        }

    }
    
// update UI is internal implementation
    private func updateViewFromModel(){
        for index in cardsButtons.indices{
//            print("update cards lenth is \(game.cards.count)")
//            print("update index is \(index)")
            let button = cardsButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                print("update view \(index)")
                button.setTitle(emoji(for:card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)

                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

            }
        }
    }
    
// either privte or internal works, but make private first
    private var emojiHistory:[String] = ["head"]
    private var emojiDict = [Int:String]()
    private var emojiChoices = ["👻","🎃","🧟‍♀️","🧛🏼‍♂️","🧜🏼‍♂️","💅"]
    
    private func emoji(for card: Card) -> String{
        
        if emojiDict[card.identifier] == nil, emojiChoices.count > 0{
                // peudorandom from 0 to upperbound ( unsigned UInt32) int
//                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
//                emojiDict[card.identifier] = emojiChoices.remove(at: randomIndex)
            emojiDict[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
         return emojiDict[card.identifier] ?? "?"
    }
    
}
// out side ViewController class extend Int class
extension Int{
    var arc4random: Int {
        if self>0{
            return Int(arc4random_uniform(UInt32(self)))
        }else if self<0{
            return -Int(arc4random_uniform(UInt32(abs(self) )))
        }else{
            return 0
        }
    }
}


