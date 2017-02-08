//
//  playController2.swift
//  animationTestV7
//
//  Created by Prashant Rathod on 12/04/2016.
//  Copyright © 2016 PrashantRathod. All rights reserved.
//

import UIKit
import AVFoundation
import GameKit

class playController2: UIViewController {

    /*
     The IBOutlets below show the 5 images of the animating musical symbols.
     */
    @IBOutlet var image1: UIImageView!
    @IBOutlet var image2: UIImageView!
    @IBOutlet var image3: UIImageView!
    @IBOutlet var image4: UIImageView!
    @IBOutlet var image5: UIImageView!
    
    /*
     The IBOutlets below are the two interactive buttons
     for the user to select.
     */
    
    @IBOutlet var showScores: UIButton!
    @IBOutlet var tap: UIButton!
    
    /*
     The IBOutlets below shows the current score on the screen,
     this is a label that updates as the score increases or decreases.
     */
    @IBOutlet var currScore: UILabel!
    
    
    /*
     The variables below are used in the functions displayed in this viewController.
     */
    var score = 0
    var audioPlayer = AVAudioPlayer()
    var audioPlayer2 = AVAudioPlayer()
    var isAnimating = true
    var isPlaying = true
    var mytimer : NSTimer?
    var counter = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         The code below is the timer, called 'mytimer', that essentially runs all the functions
         to allow my animations, and beats to occour at the same time.
         */
        
        mytimer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: #selector(playController2.imageAnimations), userInfo: nil, repeats: true)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     This function dictates what happens when the 'TAP' button is selected,
     it not only increments or decrements the score depending on the accurace of the
     users tap towards the beat, but also calls the 'test()' function and the
     'gameover()' function, these will be talked about in more detail further below.
     */
   
    
    @IBAction func tapButton(sender: AnyObject) {
        currScore.text = "SCORE :     \(score)"
        testScore()
        gameover()
        
        if(image1.isAnimating() == true){
            score = score + 1
        }
        else if(image2.isAnimating() == true){
            score = score + 1
            
        }else if(image3.isAnimating() == true){
            score = score + 1
            
        }else if(image4.isAnimating() == true){
            score = score + 1
        }else if(image5.isAnimating() == true){
            score = score + 1
        }else{
            score = score - 3
            counter = counter + 1
            
        }

    }
    
    /*
     This function determines what level the user should be on,
     if the if statement is tru, then the user will move to
     the next level. Furthermore the score is saves to Game
     Centre.
     */
    
    func testScore(){
        
        if score == 20{
            
            saveHighscore(score)
            mytimer?.invalidate()
            //performSegueWithIdentifier("toLevel2", sender: nil)
            
            
        }
    }

    /*
     This function checks if the users score has been reduced
     on three occasions, if this is the case the game finishes,
     and the gaveover view controller is displayed.
     */
    
        func gameover(){
            
            if(counter == 3){
                
                saveHighscore(score)
                mytimer?.invalidate()
                performSegueWithIdentifier("segA2", sender: nil)
                
                
            }
            
            
        }
    
    /*
     This Function stops the timer that runs the animation
     and the beats, and displays the leaderboard from the
     ViewController3.swift file.
     */
    
    @IBAction func showScoresButton(sender: AnyObject) {

        
        mytimer?.invalidate()
        
        
    }
    
    /*
     the function below provides the delay between
     each animation and beat sound, it allows me to
     seperate each animation by a double value of
     my choice.
     */
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    /*
     The function below uses the AVFoundation kit
     to allow the application to play the audio,
     it also allows me to add and play music of my choice,
     therefore allowing me to easily change the beat.
     */
    
    func playAudio() {                                                                              // this function will be called with the animations
        do {
            if let bundle = NSBundle.mainBundle().pathForResource("r4", ofType: "mp3") {         // here we are accessing the chosen music file (mp3 format)
                let alertSound = NSURL(fileURLWithPath: bundle)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)     // the file is located in the sounds resource folder
                try AVAudioSession.sharedInstance().setActive(true)
                try audioPlayer = AVAudioPlayer(contentsOfURL: alertSound)
                
                audioPlayer.prepareToPlay()
                audioPlayer.play()                                                                  // call to play the audio file
            }
        } catch {
            print(error)
        }
    }
    
    /*
     The function below uses the AVFoundation kit
     to allow the application to play the audio,
     it also allows me to add and play music of my choice,
     therefore allowing me to easily change the beat.
     */
    
    func playAudio2() {                                                                              // this function will be called with the animations
        do {
            if let bundle = NSBundle.mainBundle().pathForResource("s", ofType: "mp3") {         // here we are accessing the chosen music file (mp3 format)
                let alertSound = NSURL(fileURLWithPath: bundle)
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)     // the file is located in the sounds resource folder
                try AVAudioSession.sharedInstance().setActive(true)
                try audioPlayer2 = AVAudioPlayer(contentsOfURL: alertSound)
                
                audioPlayer2.prepareToPlay()
                audioPlayer2.play()                                                                  // call to play the audio file
            }
        } catch {
            print(error)
        }
    }
    
    
    func imageAnimations(){
        
        
        
        
        var imgArray = [UIImage]()
        for var x = 1; x <= 2; x += 1 {
            let img = UIImage(named: "p\(x).png")
            
            imgArray.append(img!)   // load images into the array for animation, i.e. the images to be animated
        }
        
        image1.animationImages = imgArray   // this will load the array of images created before.
        image1.animationDuration = 0.3      // the duration the animation will last for.
        image1.animationRepeatCount = 1     // number of times you want the image to cycle through.
        image1.isAnimating()
        image1.startAnimating()             // start animation.
        playAudio()
        
        delay(0.4){
            self.image2.animationImages = imgArray   // this will load the array of images created before.
            self.image2.animationDuration = 0.5     // the duration the animation will last for.
            self.image2.animationRepeatCount = 1     // number of times you want the image to cycle through.
            self.image2.isAnimating()
            self.image2.startAnimating()             // start animation.
            self.playAudio2()
        }
        
        delay(0.9){
            
            self.image3.animationImages = imgArray   // this will load the array of images created before.
            self.image3.animationDuration = 0.3      // the duration the animation will last for.
            self.image3.animationRepeatCount = 1     // number of times you want the image to cycle through.
            self.image3.isAnimating()
            self.image3.startAnimating()             // start animation.
            self.playAudio()
            
        }
        
        
        delay(1.4){
            self.image4.animationImages = imgArray   // this will load the array of images created before.
            self.image4.animationDuration = 0.3      // the duration the animation will last for.
            self.image4.animationRepeatCount = 1     // number of times you want the image to cycle through.
            self.image4.isAnimating()
            self.image4.startAnimating()             // start animation.
            self.playAudio()
            
        }
        
        
        delay(1.8){
            self.image5.animationImages = imgArray   // this will load the array of images created before.
            self.image5.animationDuration = 0.5      // the duration the animation will last for.
            self.image5.animationRepeatCount = 1     // number of times you want the image to cycle through.
            self.image5.isAnimating()
            self.image5.startAnimating()             // start animation.
            self.playAudio2()
        }
        
    }
    
    /*
     This function is used to save the score to
     Game Centre, it is called in the previous
     testScore() & gameover() funtions. it saves
     the score to a leaderboard table this i have
     created with my itunes connect account. The name of the
     leaderoard as it is identified in itunes connect
     is called 'level2Highscore'.
     */
    
    
    func saveHighscore(number : Int){
        
        if GKLocalPlayer.localPlayer().authenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "level2Highscore")
            
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.reportScores(scoreArray, withCompletionHandler: nil)
            
        }
        
        
    }
    
    
    
    

}
