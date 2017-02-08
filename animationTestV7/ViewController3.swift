//
//  ViewController3.swift
//  animationTestV7
//
//  Created by Prashant Rathod on 10/04/2016.
//  Copyright © 2016 PrashantRathod. All rights reserved.
//

import UIKit
import GameKit

class ViewController3: UIViewController, GKGameCenterControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        
        showLeaderBoard()   // displays the leaderboard on screen. (this a calling the function)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    /* 
     The code below describes game centre being displayed on the screen, 
     this function is called automatically, when the view is loaded,
     and presents the Game centre leaderboard for the current level.
     
    */
    func showLeaderBoard() {
        var vc = self
        var gc = GKGameCenterViewController()
        gc.gameCenterDelegate = self
        vc.presentViewController(gc, animated: true, completion: nil)
    }
    
    /*
     This function dismisses the Game Centre leaderboard when the 'done'
     is selected. removing the leaderboard from the screen, presenting the 
     user with two options, go back to the main menu, or retry the level.
    */
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismissViewControllerAnimated(true, completion: nil)
        
    }

    
}