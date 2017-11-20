//
//  ViewController.swift
//  Bullseye
//
//  Created by Alan Paul Paragas on 11/12/17.
//  Copyright © 2017 Alan Paul Paragas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var currentValue: Int = 0
    //IBOutlet links to main view controller scene
     @IBOutlet weak var slider: UISlider!
     @IBOutlet weak var randomguess: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var RoundNum: UILabel!
    var roundNum = 0  //round tracker
    var targetValue = 0 //guess target
    var totalScore = 0 // scores of all current rounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentValue = lroundf(slider.value) //get method to set inital value
        scoreLabel.text = "0"
        RoundNum.text = "0"
       startNewRound()
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")//UIImage (named: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted") //UIImage (named: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        //inset resizeable
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = UIImage(named: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage?.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = UIImage(named: "SliderTrackRight")
        let trackRightResizable = trackRightImage?.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }
    //start new round , incremental
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100)) //set random number
        currentValue = 50
        slider.value = Float(currentValue)
        roundNum += 1
        updateLabels()
    }
    // Outlet Labels updated
    func updateLabels(){
        randomguess.text = String(targetValue)
        scoreLabel.text = String(totalScore)
        RoundNum.text = String(roundNum)
    }
    //Reset Game and attributes
    func resetGame(){ //reset all variables upon UIaction
        roundNum = 0
        totalScore = 0
        updateLabels()
        startNewRound()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Main slider
    @IBAction func sliderMoved(_ slider: UISlider){
        print("The value of slider is now: \(slider.value)")
        currentValue = lroundf(slider.value)
    }
    //Start Again Button
    @IBAction func startagain(){
        resetGame()
    }
    @IBAction func showAlert(){
        //calculate score
        let difference: Int = abs(currentValue - targetValue)
        var score = 100-difference
        //title display for score
        let titlealert: String
        if difference == 0 {
            titlealert = "Perfect!"
            score += 100 //bonus for guessing perfect
        }
        else if difference < 5 {
            titlealert = "Almost had it!"
        }
        else if difference < 10 {
            titlealert = "Nice!"
        }
        else  {
            titlealert = "Try harder!"
        }
        //append current score to total
        totalScore += score // adds additional score to scoreLabel
        
        //create sting message with current value if hitme
        let message = "Your Score is: \(score)"
        let alert = UIAlertController(title: titlealert, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Confirm", style: .default, handler: {
            action in
            self.startNewRound()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

