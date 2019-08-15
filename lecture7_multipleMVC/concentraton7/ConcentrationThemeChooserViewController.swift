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

// in ipad, we will split the  view. drag split view controller , ctrl drag splitvieController to nevivator with master view controller. control drag to detail with detail vie controller
import UIKit
// to set default view as menu, master view, add protocal as UISplitViewDelegate
class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {

    // Delegate?? : https://medium.com/@jamesrochabrun/implementing-delegates-in-swift-step-by-step-d3211cbac3ef
    // to make adaptable for iphone ?? https://stackoverflow.com/questions/31993079/difference-between-awakefromnib-and-viewdidload-in-swift
    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    // when split view controller not working: https://stackoverflow.com/questions/29506713/open-uisplitviewcontroller-to-master-view-rather-than-detail
    override func viewDidLoad() {
        splitViewController?.delegate = self
        splitViewController?.preferredDisplayMode = .allVisible
    }
    
    // to make adaptable for iphone
    // CUSTOM:          "I'm adapting to the fact I'm a SplitViewController for iPhone and I want to collapse on the Detail page using a NavigationController. Should I do it?"
    // return true:     "Don't do it"
    // return false:    "I did not collapse this, so you do it!"
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool
    {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }

        return false
    }
    
    

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

                            }
                        }
                    }
                }
            }

        }
    
   
}
