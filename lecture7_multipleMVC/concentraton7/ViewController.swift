//
//  ViewController.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/30/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.

import UIKit

class ViewController: UIViewController {

    @IBOutlet private var cardsButtons: [UIButton]!
    
// get only property, so private by nature
    var pairNumber: Int{
        return (cardsButtons.count+1) / 2
    }
    
// game is a model, can be public, tied to UI(which tied to viewController), therefore set as private
    private lazy var game = Concentration(numberOfPairesOfCards: pairNumber)
    

    private func updateFlipCountLabel()
    {
        let attributes: [NSAttributedStringKey:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.lightGray
        ]
        
        let text_flipCount = "Flips: \(flipCount)"
        
        let attributedString = NSAttributedString(string: text_flipCount, attributes: attributes)
        
        // flipCountLabel.text =
        flipCountLabel.attributedText = attributedString
    }
    
// don't want other class to set flipCount
    private(set) var flipCount = 0
    {

        didSet{
            updateFlipCountLabel()

        }
    }

// UI Outlet, actions, need to be private
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet{
//            start to attribute at first
            updateFlipCountLabel()
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardsButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }else{
            print("chosen card not in card button")
        }
    }
    
// update UI is internal implementation
    private func updateViewFromModel(){
        for index in cardsButtons.indices{

            let button = cardsButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
//                print("update view \(index)")
                button.setTitle(emoji(for:card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)

                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

            }
        }
    }
    
// either privte or internal works, but make private first
//    private var emojiHistory:[String] = ["head"]
    
    // bound a card with a emoji
    private var emojiDict = [Card:String]()
    private var emojiChoices = "👻🎃🧟‍♀️🧛🏼‍♂️🧜🏼‍♂️💅"
    
    private func emoji(for card: Card) -> String{
        
        if emojiDict[card] == nil, emojiChoices.count > 0{
// peudorandom from 0 to upperbound ( unsigned UInt32) int
// let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
// emojiDict[card.identifier] = emojiChoices.remove(at: randomIndex)
           // index of a random emoji
            let emojiStringRandomIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            
            // index and int are different type
//            let emojiStringRandomIndex = emojiChoices.count.arc4random
            emojiDict[card] = String(emojiChoices.remove(at: emojiStringRandomIndex) )
        }
         return emojiDict[card] ?? "?"
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


