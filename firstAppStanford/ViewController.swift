//
//  ViewController.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/30/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.
//

import UIKit
// class: superclass
class ViewController: UIViewController {
    // lazy don actually initialize until someone grab it, but can't use didSet 
    lazy var game = Concentration(numberOfPairesOfCards: cardsButtons.count / 2)
    // class has default initialzer
    
    
    // all instance variable need to be initalized in Swift, strong type referece, Int not necessary, 0 show Int
    var flipCount: Int = 0 {
//        code observer, evertime this var change, do below
        didSet{
            flipCountView.text = "Flip: \(flipCount)"
        }
    }
    
    // var array, change var name disconnect with view
    @IBOutlet var cardsButtons: [UIButton]!//
    
 //
    var emojiHistory:[String] = ["head"]
    //outlet create variable no need to be initialized,
    @IBOutlet weak var flipCountView: UILabel!
    
    // type of argument UIButton, named sender; -> int as return value; _no extername
    @IBAction func flipCard(_ sender: UIButton) {
        
        flipCount += 1
        if let cardNumber = cardsButtons.index(of: sender) {// let to make constant, index return Int? an optional (enumeration, assocaite with int) type:set; notset (nil) 1:15:28
//            flip(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
            emojiHistory.append(emojiChoices[cardNumber])
            print(emojiHistory)
        }else{
            print("chosen card not in card button")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
            // Your code with delay
            if self.flipCount % 2 == 0{
//                print(emojiHistory)
//                let last = self.emojiHistory.removeLast()
                let size = self.emojiHistory.count
                let last = self.emojiHistory[size-1]
//                let twoBefore = self.emojiHistory.removeLast()
                let twoBefore = self.emojiHistory[size-2]
                print("last=\(last)")
                print("twoBefore=\(twoBefore)")
                print(self.emojiHistory)
                if last != twoBefore{
                    for i in 0...8{
                        self.cardsButtons[i].setTitle("", for: UIControlState.normal)
                        self.cardsButtons[i].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                    }
                    return;
                }else{
                    return;
                }
            }
        }
    }
    
    func updateViewFromModel(){
        for index in cardsButtons.indices{
            let button = cardsButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.1049068921) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emoji = Dictionary<Int,String>() //[Int,String]
    var emojiChoices: Array<String>
        = ["👻","🎃","😼","🧛🏼‍♂️","🧟‍♀️","🤡","🦇","🧙🏻‍♂️","🧜🏼‍♂️"]
    func emoji(for card: Card) -> String{
        
        if emoji[card.identifier] == nil{
            if emojiChoices.count > 0{
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            }
        }
        
        if emoji[card.identifier] != nil{
            return emoji[card.identifier]!
        }
       
        return "?"
//        return emoji[card.identifier] ?? "?"
    }
 
    
    
    
    //External name withEmoji, internal name emoji; on external
    func flip(withEmoji emoji:String, on button:UIButton){
        print("flip: \(emoji)")
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
        }else{
            button.setTitle(emoji, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
    }
    

}

