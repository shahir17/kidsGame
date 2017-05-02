//
//  BalloonViewController.swift
//  Kid Joy Center
//
//  Created by Shahir Abdul-Satar on 3/18/17.
//  Copyright © 2017 Ahmad Shahir Abdul-Satar. All rights reserved.
//

import UIKit

class BalloonViewController: UIViewController {
    var gameName = "Balloon Game"
    var diff = ""
    var countDownLabel: UILabel!
    var seconds = 60
    var skullImageView: UIImageView!
    var levelArray: Array<String> = []
    var balloonImages: Array<String> = []
    var imageView1: UIImageView!
    var timeLabel: UIImageView!
    var scoreLabel: UIImageView!
    var score: UILabel!
    var timer = Timer()
    var isTimeRunning = false
    var speed = 0
    var balloonNumber = 0
    var two: Any!
    var delay: Array<Int> = []
    var numberLabel: UILabel!
    var count = 0
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(MemoryViewController.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer(){
        if seconds < 1 {
            timer.invalidate()
            
            let alert = UIAlertController(title: "You Lost!", message: "Play Again?", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.destructive, handler: { action in
            self.navigationController?.popToRootViewController(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: {action in
            self.navigationController?.popToRootViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)

        }
        
        else{
             seconds -= 1
            countDownLabel.text = timeString(time: TimeInterval(seconds))
            }
        
        }
    
    
    
    func timeString(time:TimeInterval) -> String {
        
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sky-background")
        self.view.insertSubview(backgroundImage, at: 0)

        
        countDownLabel = UILabel(frame: CGRect(x: 130, y: 35, width: 200, height: 100))
        countDownLabel.font = UIFont(name: countDownLabel.font.fontName, size: 28)
        self.view.addSubview(countDownLabel)
        countDownLabel.isUserInteractionEnabled = false
        
        
        navigationItem.title = "Balloon Pop"
        timeLabel = UIImageView(frame: CGRect(x: 0, y: 35, width: 100, height: 100))
        timeLabel.isUserInteractionEnabled = false
        timeLabel.image = UIImage(named: "time")
        timeLabel.contentMode = .scaleAspectFit
        self.view.addSubview(timeLabel)
        
        scoreLabel = UIImageView(frame: CGRect(x: 820, y: 35, width: 100, height: 100))
        scoreLabel.image = UIImage(named: "score")
        scoreLabel.contentMode = .scaleAspectFit
        self.view.addSubview(scoreLabel)
        scoreLabel.isUserInteractionEnabled = false
        score = UILabel(frame: CGRect(x: 950, y: 35, width: 200, height: 100))
        score.font = UIFont(name: score.font.fontName, size: 28)
        score.text = String(0)
        self.view.addSubview(score)
        
        score.isUserInteractionEnabled = false
        balloonImages = ["color1", "color2", "color3", "color4", "color5", "color6", "color7", "color8", "color9", "color10"]
        print(balloonNumber)
        if (diff == "Easy"){
            seconds = 60
            runTimer()
        }
        if (diff == "Medium"){
            seconds = 45
            runTimer()
        }
        if (diff == "Hard"){
            seconds = 30
            runTimer()
        }
    
        setUp()


        // Do any additional setup after loading the view.
    }
    
    
    func animate(v: UIView, delay: Int, speed: Int){
        
        //speed = Int(v.frame.origin.y)/200
        UIView.animate(withDuration: TimeInterval(speed), delay: TimeInterval(delay), options: [.repeat,.allowUserInteraction], animations: {
            var fr = v.frame
            fr.origin.y -= self.view.frame.height + 200
            v.frame = fr
        }, completion: nil)

    }
    
    
    
    
    func setUp(){
        
        
        if (diff == "Easy"){
            for _ in 0...8{
            var randomIndex = Int(arc4random_uniform(UInt32(balloonImages.count)))
            levelArray += [balloonImages[randomIndex]]
            }
            
            var imageView1: UIImageView = UIImageView(frame: CGRect(x: 0, y: 850, width: 80, height: 100))
            var imageView2: UIImageView = UIImageView(frame: CGRect(x: 110, y: 850, width: 80, height: 100))
            var imageView3: UIImageView = UIImageView(frame: CGRect(x: 220, y: 850, width: 80, height: 100))
            var imageView4: UIImageView = UIImageView(frame: CGRect(x: 330, y: 850, width: 80, height: 100))
            var imageView5: UIImageView = UIImageView(frame: CGRect(x: 440, y: 850, width: 80, height: 100))
            var imageView6: UIImageView = UIImageView(frame: CGRect(x: 550 , y: 850, width: 80, height: 100))
            var imageView7: UIImageView = UIImageView(frame: CGRect(x: 660, y: 850, width: 80, height: 100))
            var imageView8: UIImageView = UIImageView(frame: CGRect(x: 770 , y: 850, width: 80, height: 100))
            var imageView9: UIImageView = UIImageView(frame: CGRect(x: 880, y: 850, width: 80, height: 100))
            speed = Int(imageView1.frame.origin.y)/100

            imageView1.image = UIImage(named: levelArray[0])
            imageView1.contentMode = .scaleAspectFit
            imageView1.isUserInteractionEnabled = true
            imageView1.backgroundColor = UIColor.clear
            imageView1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView1)
            
            imageView2.image = UIImage(named:levelArray[1])
            imageView2.contentMode = .scaleAspectFit
            imageView2.isUserInteractionEnabled = true
            imageView2.backgroundColor = UIColor.clear
            imageView2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView2)
            
            imageView3.image = UIImage(named:levelArray[2])
            imageView3.contentMode = .scaleAspectFit
            imageView3.isUserInteractionEnabled = true
            imageView3.backgroundColor = UIColor.clear
            imageView3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView3)
            
            imageView4.image = UIImage(named:levelArray[3])
            imageView4.contentMode = .scaleAspectFit
            imageView4.isUserInteractionEnabled = true
            imageView4.backgroundColor = UIColor.clear
            imageView4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView4)
            
            imageView5.image = UIImage(named:levelArray[4])
            imageView5.contentMode = .scaleAspectFit
            imageView5.isUserInteractionEnabled = true
            imageView5.backgroundColor = UIColor.black
            imageView5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView5)
            
            imageView6.image = UIImage(named:levelArray[5])
            imageView6.contentMode = .scaleAspectFit
            imageView6.isUserInteractionEnabled = true
            imageView6.backgroundColor = UIColor.clear
            imageView6.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView6)
            
            imageView7.image = UIImage(named:levelArray[6])
            imageView7.contentMode = .scaleAspectFit
            imageView7.isUserInteractionEnabled = true
            imageView7.backgroundColor = UIColor.yellow
            imageView7.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView7)
            
            imageView8.image = UIImage(named:levelArray[7])
            imageView8.contentMode = .scaleAspectFit
            imageView8.isUserInteractionEnabled = true
            imageView8.backgroundColor = UIColor.clear
            imageView8.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView8)
            
            imageView9.image = UIImage(named:levelArray[8])
            imageView9.contentMode = .scaleAspectFit
            imageView9.isUserInteractionEnabled = true
            imageView9.backgroundColor = UIColor.clear
            imageView9.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView9)
            animate(v: imageView1, delay: 1, speed: speed)
            animate(v: imageView5, delay: 3, speed: speed)
            animate(v: imageView4, delay: 4, speed: speed)
            animate(v: imageView3, delay: 8, speed: speed)
            animate(v: imageView2, delay: 3, speed: speed)
            animate(v: imageView6, delay: 7, speed: speed)
            animate(v: imageView7, delay: 5, speed: speed)
            animate(v: imageView8, delay: 2, speed: speed)


            
            
        }
        if (diff == "Medium"){
            
            for _ in 0...6{
                var randomIndex = Int(arc4random_uniform(UInt32(balloonImages.count)))
                levelArray += [balloonImages[randomIndex]]
            }
            
            
            
            var delayArray = [1,1,1, 2, 2, 3,3, 3, 4, 5]
            
            var imageView1: UIImageView = UIImageView(frame: CGRect(x: 0, y: 900, width: 80, height: 100))
            var imageView2: UIImageView = UIImageView(frame: CGRect(x: 150, y: 900, width: 80, height: 100))
            var imageView3: UIImageView = UIImageView(frame: CGRect(x: 300, y: 900, width: 80, height: 100))
            var imageView4: UIImageView = UIImageView(frame: CGRect(x: 450, y: 900, width: 80, height: 100))
            var imageView5: UIImageView = UIImageView(frame: CGRect(x: 600, y: 900, width: 80, height: 100))
            var imageView6: UIImageView = UIImageView(frame: CGRect(x: 750 , y: 900, width: 80, height: 100))
            var imageView7: UIImageView = UIImageView(frame: CGRect(x: 900, y: 900, width: 80, height: 100))
            
            
            
            speed = Int(imageView1.frame.origin.y)/150
            
            imageView1.image = UIImage(named: levelArray[0])
            imageView1.contentMode = .scaleAspectFit
            imageView1.isUserInteractionEnabled = true
            imageView1.backgroundColor = UIColor.clear
            imageView1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView1)
            
            imageView2.image = UIImage(named:levelArray[1])
            imageView2.contentMode = .scaleAspectFit
            imageView2.isUserInteractionEnabled = true
            imageView2.backgroundColor = UIColor.yellow
            imageView2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView2)
            
            imageView3.image = UIImage(named:levelArray[2])
            imageView3.contentMode = .scaleAspectFit
            imageView3.isUserInteractionEnabled = true
            imageView3.backgroundColor = UIColor.clear
            imageView3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView3)
            
            imageView4.image = UIImage(named:levelArray[3])
            imageView4.contentMode = .scaleAspectFit
            imageView4.isUserInteractionEnabled = true
            imageView4.backgroundColor = UIColor.clear
            imageView4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView4)
            
            imageView5.image = UIImage(named:levelArray[4])
            imageView5.contentMode = .scaleAspectFit
            imageView5.isUserInteractionEnabled = true
            imageView5.backgroundColor = UIColor.black
            imageView5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView5)
            
            imageView6.image = UIImage(named:levelArray[5])
            imageView6.contentMode = .scaleAspectFit
            imageView6.isUserInteractionEnabled = true
            imageView6.backgroundColor = UIColor.clear
            imageView6.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView6)
            
            imageView7.image = UIImage(named:levelArray[6])
            imageView7.contentMode = .scaleAspectFit
            imageView7.isUserInteractionEnabled = true
            imageView7.backgroundColor = UIColor.clear
            imageView7.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView7)
            animate(v: imageView1, delay: 1, speed: speed)
            animate(v: imageView5, delay: 3, speed: speed)
            animate(v: imageView4, delay: 4, speed: speed)
            animate(v: imageView3, delay: 2, speed: speed)
            animate(v: imageView2, delay: 3, speed: speed)
            animate(v: imageView6, delay: 2, speed: speed)
            animate(v: imageView7, delay: 2, speed: speed)
            
    
        }
        if (diff == "Hard"){
            for _ in 0...4{
                var randomIndex = Int(arc4random_uniform(UInt32(balloonImages.count)))
                levelArray += [balloonImages[randomIndex]]
            }
            
            
            var imageView1: UIImageView = UIImageView(frame: CGRect(x: 20, y: 850, width: 80, height: 100))
            var imageView2: UIImageView = UIImageView(frame: CGRect(x: 220, y: 850, width: 80, height: 100))
            var imageView3: UIImageView = UIImageView(frame: CGRect(x: 420, y: 850, width: 80, height: 100))
            var imageView4: UIImageView = UIImageView(frame: CGRect(x: 620, y: 850, width: 80, height: 100))
            var imageView5: UIImageView = UIImageView(frame: CGRect(x: 820, y: 850, width: 80, height: 100))
            
            speed = Int(imageView1.frame.origin.y)/200
            imageView1.image = UIImage(named:levelArray[0])
            imageView1.contentMode = .scaleAspectFit
            imageView1.isUserInteractionEnabled = true
            imageView1.backgroundColor = UIColor.clear
            imageView1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            
            self.view.addSubview(imageView1)
            
                                    imageView2.image = UIImage(named:levelArray[1])
            imageView2.contentMode = .scaleAspectFit
            imageView2.isUserInteractionEnabled = true
            imageView2.backgroundColor = UIColor.clear
            imageView2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView2)
            
            
            
            
            
            
            imageView3.image = UIImage(named:levelArray[2])
            imageView3.contentMode = .scaleAspectFit
            imageView3.isUserInteractionEnabled = true
            imageView3.backgroundColor = UIColor.black
            imageView3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
                
            
            self.view.addSubview(imageView3)
            
            
            
            
            imageView4.image = UIImage(named:levelArray[3])
            imageView4.contentMode = .scaleAspectFit
            imageView4.isUserInteractionEnabled = true
            imageView4.backgroundColor = UIColor.clear
            imageView4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView4)
            
            
            
            
            
            imageView5.image = UIImage(named:levelArray[4])
            imageView5.contentMode = .scaleAspectFit
            imageView5.isUserInteractionEnabled = true
            imageView5.backgroundColor = UIColor.yellow
            imageView5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(BalloonViewController.touchesBegan(_:with:))))
            self.view.addSubview(imageView5)
            
            
            
                animate(v: imageView1, delay: 0, speed: speed)
            animate(v: imageView5, delay: 3, speed: speed )
            animate(v: imageView4, delay: 7, speed: speed)
            animate(v: imageView3, delay: 4, speed: speed)
                animate(v: imageView2, delay: 9, speed: speed)
            
        }
        
        
        
        
    }
    
   
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        scoreLabel.isUserInteractionEnabled = false
        timeLabel.isUserInteractionEnabled = false
        let touch = touches.first
        
        let touchLocation = touch!.location(in: self.view)
        
        for i in 2...self.view.subviews.count {
            if self.view.subviews[i-1].layer.presentation()!.hitTest(touchLocation) != nil {
               count += 1
                
                self.view.subviews[i-1].isHidden = true
                
                    score.text = String(count)
            }
            else {
                self.view.subviews[i-1].isHidden = false
            }
            
        }
       
        
        
        
        
    }


    
    
       
}
