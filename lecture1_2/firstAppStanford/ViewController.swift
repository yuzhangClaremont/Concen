//
//  ViewController.swift
//  firstAppStanford
//
//  Created by Yun Zhang on 7/30/18.
//  Copyright © 2018 Yun Zhang. All rights reserved.

// right click on UI to find all connections
// cmd+left click on code to rename
// MVC: Model(what), view(UI element), controller(how ) only control one screen:
// story board: view; view controller: Controller. model: swift file; a new view controler: cocoa

import UIKit // top cocoa layer
// class: superclass (swift inheret)
class ViewController: UIViewController {

    // var array, change var name disconnect with view
    // drag with all cards to this array
    // the array from controller to model
    @IBOutlet var cardsButtons: [UIButton]!// can't be nil?
    
    //ctl+drag outlet create property no need to be initialized, because ! unwrapper
    @IBOutlet weak var flipCountLabel: UILabel!
    //  all instance variable () need to be initalized in Swift, strong type referece, Int not necessary, 0 show Int
    var flipCount: Int = 0 {
        // Property observer, evertime this var change, do below. Different from computed property do not set value
        didSet{
            flipCountLabel.text = "Flip: \(flipCount)"
        }
    }

    // lazy don actually initialize until someone grab it, to save memory https://medium.com/@abhimuralidharan/lazy-var-in-ios-swift-96c75cb8a13a use it to prevent "property initializer run before self error" ??
    lazy var game = Concentration(numberOfPairesOfCards: (cardsButtons.count+1) / 2)
    
    @IBOutlet weak var winLabel: UILabel!
//    var matchCount: Int  {
//        if self.matchCount == cardsButtons.count{
//            winLabel.text = "Yeah! You won with \(flipCount) flips"
//            return cardsButtons.count
//        }else{
//            return 0
//        }
//    }
    
    
    // action funciton
//    func flipCard(withEmoji emoji:String, on button:UIButton){
//        print("flip: \(emoji)")
//        if button.currentTitle == emoji {
//            
//            button.setTitle("", for: UIControlState.normal)
//            // a UIColor class color literal
//            button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//        }else{
//            // opt+mouse to find document
//            button.setTitle(emoji, for: UIControlState.normal)
//            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        }
//        
//    }
    
    // ctrl+drag line to build a action connection(IBAction) as a funciton. The type is UIButton. when touch a button connected from UI, run this function
    @IBAction func touchCard(_ sender: UIButton) {
        print((cardsButtons.count+1) / 2)
        flipCount += 1
        // if cardNumber is not nil(in set state), cardNumber is choose index from 0 to 7
        if let cardNumber = cardsButtons.index(of: sender) {
            print("cardnumber, \(cardNumber)")
//   flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
  // update view only when a card is touched
            updateViewFromModel()
            
//            emojiHistory.append(emojiChoices[cardNumber])
//            print(emojiHistory)
        }else{
            print("chosen card not in card button")
        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
//            // Your code with delay
//            if self.flipCount % 2 == 0{
////                print(emojiHistory)
////                let last = self.emojiHistory.removeLast()
//                let size = self.emojiHistory.count
//                let last = self.emojiHistory[size-1]
////                let twoBefore = self.emojiHistory.removeLast()
//                let twoBefore = self.emojiHistory[size-2]
//                print("last=\(last)")
//                print("twoBefore=\(twoBefore)")
//                print(self.emojiHistory)
//                if last != twoBefore{
//                    for i in 0...8{
//                        self.cardsButtons[i].setTitle("", for: UIControlState.normal)
//                        self.cardsButtons[i].backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
//                    }
//                    return;
//                }else{
//                    return;
//                }
//            }
//        }
    }
    

    
//    var emojiHistory:[String] = ["head"]
    var emojiDict = [Int:String]() //[Int,String]
    var emojiChoices = ["👻","🎃","🧟‍♀️","🧛🏼‍♂️"]
    
    func emoji(for card: Card) -> String{
        if emojiDict[card.identifier] == nil, emojiChoices.count > 0{
                // peudorandom from 0 to upperbound ( unsigned UInt32) int
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            // randomly shuffle emojiChoices and assign to a pair of card's identifier
                emojiDict[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
//        if emojiDict[card.identifier] != nil{
//            return emojiDict[card.identifier]!
//        }
//
//        return "?"
        // return emoji, if nil, return "?"
        
         return emojiDict[card.identifier] ?? "?"
    }

    func updateViewFromModel(){
        //        print(cardsButtons.indices) 0..<8
        for index in cardsButtons.indices{
            print("update cards lenth is \(game.cards.count)")
            print("update index is \(index)")
            let button = cardsButtons[index]
            let card = game.cards[index]
            if card.isFaceUp{
                button.setTitle(emoji(for:card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("", for: UIControl.State.normal)
                // if matched and face down, be clear, if face down but not matched, turn back to orange
                //                colorLiteral
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0):#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                //                    #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0.1049068921) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        if game.matchCount == cardsButtons.count{
            winLabel.text = "Yeah! You won with \(flipCount) flips"
        }

    }
  

}

