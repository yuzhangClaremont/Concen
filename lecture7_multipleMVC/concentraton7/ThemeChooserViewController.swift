//
//  ThemeChooserViewController.swift
//  concentraton7
//
//  Created by Yun Zhang on 8/13/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {

   
    // Themes
    let themes = [
        "SPORTS": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓🏸🥊🥋",
        "ANIMALS": "🐶🐱🐭🐹🐰🦊🐻🐼🐷🐸🐧🐣",
        "FACES": "😃😍😎🤪😜😫😡😰🤢🤩😘😌",
        ]
    //    //
    //    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // sender build a segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "choose theme"
        {
            if let button = sender as? UIButton // sender is type Any? https://jayeshkawli.ghost.io/swift-3-0-whats-is-as-as-and-as-operators/
            {
                if let themeName = button.currentTitle
                {
                    // Check: If the title of the [sender] button matches a title in our themes dictionary
                    if let theme = themes[themeName]
                    {// destination is a UIViewcontroler, so down cast to concentration viewcontroller
                        if let cvc = segue.destination as? ConcentrationViewController {
                            cvc.theme = theme // cvc. them in ConcentraonViewController
                            //                            lastSeguedToConcentrationViewController = cvc
                        }
                    }
                }
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
