//
//  ViewController.swift
//  animationTestV7
//
//  Created by Prashant Rathod on 30/03/2016.
//  Copyright © 2016 PrashantRathod. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        authPlayer()

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    /* The code below is used to authenticate the user has a Game Centre account, if not they are presented
    with a screen to sign up/login */
    
    func authPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                
                self.presentViewController(view!, animated: true, completion: nil)
                
            }
            else {
                
                print(GKLocalPlayer.localPlayer().authenticated)
                
            }
            
            
        }
    }
    


}

