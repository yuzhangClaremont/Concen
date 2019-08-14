//
//  ConcentrationThemeChooserViewController.swift
//  concentraton7
//
//  Created by Yun Zhang on 8/13/19.
//  Copyright © 2019 Yun Zhang. All rights reserved.
//

// drag a new viewController scene in storyboard library. Then build a new cocotouch file for it as UI, and in storyboard IdentityInspector custom class choose class. Drag the arrow to the theme view.
// STACK them together

// ctrl drag from menu to concentration SHOW, change identifier to choose scene
// segue - https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/UsingSegues.html

// editor, embed in, nevigation controller

// MGIsDeviceOneOfType is not supported on this platform. disable scheme: https://stackoverflow.com/questions/50701321/xcode-error-on-simulator-mgisdeviceoneoftype-is-not-supported-on-this-platform?noredirect=1&lq=1

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {


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
    
   
    
    // [!]: iPad only: Only iPads have SplitViewController
//    private var splitViewDetailConcentrationViewController:ConcentrationViewController? {
//        return splitViewController?.viewControllers.last as? ConcentrationViewController
//    }
//
    // Strong pointer
//    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if segue.identifier == "Choose Theme" {
//
//
//            // Short way:
//            if let themeName = (sender as? UIButton)?.currentTitle,
//                let theme = themes[themeName] {
//
//                // Case: Successful segue
//                // [!]: Typecast from superclass [UIViewController] to child: [ConcentrationViewController]
//                if let cvc = segue.destination as? ConcentrationViewController {
//                    cvc.theme = theme
////                    lastSeguedToConcentrationViewController = cvc
//                }
//            }
//
//
//        }
//    }

}
