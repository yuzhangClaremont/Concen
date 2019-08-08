//
//  ViewController.swift
//  PlayingCard
//
//  Created by Yun Zhang on 7/31/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var deck = PlayingCardDeck()
    // tap action
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state{
        case .ended: playingCardView.isFaceUp = !playingCardView.isFaceUp
        default: break
        }
        
    }
    
    // swipe to look next card
    @IBOutlet weak var playingCardView: PlayingCardView!{
        didSet{
            // swipe affect model, so should be handled by controller
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard) )
            swipe.direction = [.left, .right]
            playingCardView.addGestureRecognizer(swipe)
            
            // Gesture: Pinch (this gesture works only on FACE cards (J, Q, K)
            // ?? not working
            let pinch = UIPinchGestureRecognizer(target: playingCardView, action: #selector(PlayingCardView.adjustFaceCardScale(byHandlingGestureRecognizedBy:)) ) // // Define gesture
            playingCardView.addGestureRecognizer(pinch) // Gesture recognizer: Add it to the view
        }
    }
    
    @objc func nextCard(){
        if let card = deck.draw(){
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    
    
    // this will run after compiled, good place to debug view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        for _ in 1...10
//        {
//            if let card = deck.draw()
//            {
//                print("\(card)")
//            }
//        }
        

        
    }


}

