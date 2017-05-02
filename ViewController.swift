//
//  ViewController.swift
//  Kid Joy Center
//
//  Created by Shahir Abdul-Satar on 3/16/17.
//  Copyright © 2017 Ahmad Shahir Abdul-Satar. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UIGestureRecognizerDelegate{
    
    
    @IBOutlet weak var memoryGame: UIImageView!

    @IBOutlet weak var sortingGame: UIImageView!
    
    
    @IBOutlet weak var balloonGame: UIImageView!
    
    
    @IBOutlet weak var easyModeButton: UIButton!
    
    @IBOutlet weak var mediumModeButton: UIButton!
    
    
    @IBOutlet weak var hardModeButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBAction func highScoresPressed(_ sender: Any) {
        
        popUp()
    }
    var imageTap: UIView?
    var diff = ""
    
    @IBAction func playPressed(_ sender: Any) {
        
        if (imageTap == memoryGame && (diff == "Easy" || diff == "Medium" || diff == "Hard") ){
        performSegue(withIdentifier: "memorySegue", sender: self)
        
        }
        if (imageTap == sortingGame && (diff == "Easy" || diff == "Medium" || diff == "Hard")){
            performSegue(withIdentifier: "sortingSegue", sender: self)
        }
        if (imageTap == balloonGame && (diff == "Easy" || diff == "Medium" || diff == "Hard")) {
            performSegue(withIdentifier: "balloonSegue", sender: self)
        }
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "memorySegue" {
            if let destination = segue.destination as? MemoryViewController {
                if self.diff == "Easy" {
                destination.diff = self.diff
                }
                if diff == "Medium" {
                    destination.diff = self.diff
                }
                if diff == "Hard"{
                    destination.diff = self.diff
            }
                
        }
    }
        if segue.identifier == "sortingSegue" {
            if let destination = segue.destination as? SortingViewController {
                if self.diff == "Easy" {
                    destination.diff = self.diff
                }
                if diff == "Medium" {
                    destination.diff = self.diff
                }
                if diff == "Hard"{
                    destination.diff = self.diff
                }

            }
        }
        
        if segue.identifier == "balloonSegue" {
            if let destination = segue.destination as? BalloonViewController {
                if self.diff == "Easy" {
                    destination.diff = self.diff
                }
                if diff == "Medium" {
                    destination.diff = self.diff
                }
                if diff == "Hard"{
                    destination.diff = self.diff
                }
                
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        interactionEnable()
       assignDifficulty()
        
        
    }

    
    
    
    func interactionEnable(){
        
        memoryGame.isUserInteractionEnabled = true
        sortingGame.isUserInteractionEnabled = true
        balloonGame.isUserInteractionEnabled = true
        
        memoryGame.tag = 0
        sortingGame.tag = 1
        balloonGame.tag = 2
        
        let tapMemory = UITapGestureRecognizer(target: self, action: #selector(ViewController.doSomething))
        let tapSorting = UITapGestureRecognizer(target: self, action:
            #selector(ViewController.doSomething))
        let tapBalloon = UITapGestureRecognizer(target: self, action: #selector(ViewController.doSomething))
        tapMemory.delegate = self
        tapSorting.delegate = self
        tapBalloon.delegate = self
        memoryGame.addGestureRecognizer(tapMemory)
        sortingGame.addGestureRecognizer(tapSorting)
        balloonGame.addGestureRecognizer(tapBalloon)
        
        
    }
    
    func doSomething(gesture: UIGestureRecognizer){
       
         imageTap = gesture.view!
        if (imageTap == memoryGame){
            memoryGame.alpha = 1
            sortingGame.alpha = 0.3
            balloonGame.alpha = 0.3
        }
        else if (imageTap == sortingGame) {
            sortingGame.alpha = 1
            memoryGame.alpha = 0.3
            balloonGame.alpha = 0.3
        }
        else if (imageTap == balloonGame) {
            balloonGame.alpha = 1
            memoryGame.alpha = 0.3
            sortingGame.alpha = 0.3
        }
        else {
        memoryGame.alpha = 1
        sortingGame.alpha = 1
        balloonGame.alpha = 1
        
        }
            }

    
    
    func popUp() {
        
        print("adding pop up")
    
        let newVC = UIViewController()
        newVC.view.backgroundColor = UIColor.white
        
        newVC.modalPresentationStyle = .popover
        newVC.modalTransitionStyle = .partialCurl
        
        newVC.preferredContentSize = CGSize(width: 300, height: 300)
        navigationItem.title = "Kid Joy Center"
        
        let fr = CGRect(x: 300, y: 300, width: 1, height: 1)
        let midView = UIView(frame: fr)
        self.view.addSubview(midView)
        newVC.navigationItem.title = "High Scores"
        
        let pop = newVC.popoverPresentationController
        pop?.sourceView = midView
        
        show(newVC, sender: midView)
        let gameTypeLabel: UILabel
        gameTypeLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 200, height: 200))
        gameTypeLabel.text = "Game Type"
        gameTypeLabel.backgroundColor = UIColor.cyan
        gameTypeLabel.font = UIFont(name: gameTypeLabel.font.fontName, size: 30)
        newVC.view.addSubview(gameTypeLabel)
        
        let scor: UILabel
        scor = UILabel(frame: CGRect(x: 400, y: 10, width: 200, height: 200))
        scor.text = "Score"
        scor.backgroundColor = UIColor.cyan
        scor.font = UIFont(name: scor.font.fontName, size: 30)
        newVC.view.addSubview(scor)
        
        let difficulty: UILabel
        difficulty = UILabel(frame: CGRect(x: 600, y: 10, width: 200, height: 200))
        difficulty.text = "Difficulty"
        difficulty.backgroundColor = UIColor.cyan
        difficulty.font = UIFont(name: difficulty.font.fontName, size: 30)
        newVC.view.addSubview(difficulty)
        
        
        
        let dif: UILabel
        dif = UILabel(frame: CGRect(x: 600, y:100, width: 200, height: 200))
        dif.text = diff
        dif.font = UIFont(name: dif.font.fontName, size: 26)
        newVC.view.addSubview(dif)
        
    }


}

enum Difficulty{
    case Easy, Medium, Hard
    
}

 extension ViewController {
    func assignDifficulty(){
        buttonTapped(button: easyModeButton, action: #selector(ViewController.onEasyTapped(sender:)))
        buttonTapped(button: mediumModeButton, action: #selector(ViewController.onMediumTapped(sender:)))
        buttonTapped(button: hardModeButton, action: #selector(ViewController.onHardTapped(sender:)))
        
    }
    
    func buttonTapped(button: UIButton, action: Selector) {
        let myButton = button
        myButton.addTarget(self, action: action, for: .touchUpInside)
        
        
    }
}


extension ViewController {
    func onEasyTapped(sender: UIButton) {
        
        newGameDifficulty(difficulty: .Easy)
        
    }
    func onMediumTapped(sender: UIButton){
        
        newGameDifficulty(difficulty: .Medium)
       
    }
    func onHardTapped(sender: UIButton){
        
        newGameDifficulty(difficulty: .Hard)
        
    }
    
    func newGameDifficulty(difficulty: Difficulty){
        switch difficulty {
        case .Easy:
            print(difficulty)
            diff = "Easy"
            
        case .Medium:
            print(difficulty)
            diff = "Medium"
            
        case .Hard:
            print(difficulty)
            diff = "Hard"
            
        }
    }
}





