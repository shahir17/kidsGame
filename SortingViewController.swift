//
//  SortingViewController.swift
//  Kid Joy Center
//
//  Created by Shahir Abdul-Satar on 3/18/17.
//  Copyright © 2017 Ahmad Shahir Abdul-Satar. All rights reserved.
//

import UIKit



class SortingViewController: UIViewController {
    
    var vc: ViewController = ViewController()
    var gameName = "Sorting Game"
    var countDownLabel: UILabel!
    var seconds = 60
    var originalCenter: CGPoint!
    var diff = ""
    var scoreCount = 0
    var imageView: UIImageView!
    var imageArray: Array<UIImage> = []
    var levelArray: Array<String> = []
    //var levelArray: Array<UIImage> = []
    let myWidth = 40
    let myHeight = 40
    var stringArray: Array<String> = []
    var timeLabel: UIImageView!
    var lastLocation: CGPoint = CGPoint(x: 0, y: 0)
    var scoreLabel: UIImageView!
    var score: UILabel!
    
    var skyArea: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var waterArea: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var waterArea2: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var landArea: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    var landArea2: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    
    var timer = Timer()
    var isTimeRunning = false
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
            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel, handler: { action in
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
        backgroundImage.image = UIImage(named: "air-land-water")
        self.view.insertSubview(backgroundImage, at: 0)
        imageView =  UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        imageView.backgroundColor = UIColor.cyan
        self.view.addSubview(imageView)
        countDownLabel = UILabel(frame: CGRect(x: 130, y: 700, width: 200, height: 100))
        countDownLabel.font = UIFont(name: countDownLabel.font.fontName, size: 28)
        self.view.addSubview(countDownLabel)
        
        navigationItem.title = "Sorting Fun"
        timeLabel = UIImageView(frame: CGRect(x: 0, y: 700, width: 100, height: 100))
        
        timeLabel.image = UIImage(named: "time")
        timeLabel.contentMode = .scaleAspectFit
        self.view.addSubview(timeLabel)

        scoreLabel = UIImageView(frame: CGRect(x: 820, y:700, width: 100, height: 100))
        scoreLabel.image = UIImage(named: "score")
        scoreLabel.contentMode = .scaleAspectFit
        self.view.addSubview(scoreLabel)
        
        score = UILabel(frame: CGRect(x: 950, y: 700, width: 200, height: 100))
        score.font = UIFont(name: score.font.fontName, size: 28)
        score.text = String(scoreCount)
        self.view.addSubview(score)

        
        
        
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

        // Do any additional setup after loading the view.
        /*imageArray += [UIImage(named: "1-1")!, UIImage(named: "1-2")!, UIImage(named: "1-3")!,UIImage(named: "1-4")!,UIImage(named: "1-5")!,UIImage(named: "2-1")!,UIImage(named: "2-2")!,UIImage(named: "2-3")!,UIImage(named: "2-4")!,UIImage(named: "2-5")!,UIImage(named: "3-1")!,UIImage(named: "3-2")!,UIImage(named: "3-3")!,UIImage(named: "3-4")!,UIImage(named: "3-5")!]*/
        
        stringArray += ["1-1","1-2","1-3","1-4","1-5","2-1","2-2","2-3","2-4","2-5","3-1","3-2","3-3","3-4","3-5",]
        
        
        
        setUp()
        
        
    }
    func handlePan(panGesture: UIPanGestureRecognizer) {
        switch panGesture.state{
        case .began:
            originalCenter = panGesture.view?.center
            
        case .changed:
            applyGestureTranslationToGestureView(recognizer: panGesture, parentView: self.view)
            
        case .ended:
            skyArea = CGRect(x: 0, y: 0, width: 950, height: self.view.frame.midY + 50)
            waterArea = CGRect(x: 0, y: self.view.frame.midY + 100, width: 600, height: self.view.frame.midY/2)
            waterArea2 = CGRect(x: 400, y: self.view.frame.midY, width: (self.view.frame.midX + 200), height: self.view.frame.midY/2)
            landArea = CGRect(x: self.view.frame.midX, y: self.view.frame.midY + 100, width: self.view.frame.width, height: self.view.frame.midY)
            landArea2 = CGRect(x: (self.view.frame.midX*(3/2)+200) , y: self.view.frame.midY, width: self.view.frame.width, height: self.view.frame.midY)

            
            var img = panGesture.view as! UIImageView
            if (img.image == UIImage(named: "1-1") || img.image == UIImage(named: "1-2") || img.image == UIImage(named: "1-3") || img.image == UIImage(named: "1-4") || img.image == UIImage(named: "1-5")){
                if (!skyArea.contains(img.center)){
                    UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {img.center = self.originalCenter}, completion: nil)
                }
                else {
                    scoreCount += 5
                    score.text = String(scoreCount)
                }
            }
            
            if (img.image == UIImage(named: "2-1") || img.image == UIImage(named: "2-2") || img.image == UIImage(named: "2-3") || img.image == UIImage(named: "2-4") || img.image == UIImage(named: "2-5")){
                if (!waterArea.contains(img.center) && !waterArea2.contains(img.center)){
                    UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {img.center = self.originalCenter}, completion: nil)
                }
                else {
                    scoreCount += 5
                    score.text = String(scoreCount)
                }
            }
            
            if (img.image == UIImage(named: "3-1") || img.image == UIImage(named: "3-2") || img.image == UIImage(named: "3-3") || img.image == UIImage(named: "3-4") || img.image == UIImage(named: "3-5")){
                if (!landArea.contains(img.center) && !landArea2.contains(img.center)){
                    UIView.animate(withDuration: 2.0, delay: 0.0, options: .curveEaseOut, animations: {img.center = self.originalCenter}, completion: nil)
                } else {
                    scoreCount += 4
                    score.text = String(scoreCount)
                }
            }
            /*
            else {
                scoreCount += 4
                score.text = String(scoreCount)
            }
            */
        
        default: ()
            
        }
    
    
    }
    func checkSky(recognizer: UIPanGestureRecognizer, parentView: UIView){
        
        
                if let recognizerView = recognizer.view {
                    let translation = recognizer.translation(in: parentView)
                    let originalCenter = recognizerView.center
                    recognizerView.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
                    skyArea = CGRect(x: 0, y: 0, width: 950, height: self.view.frame.midY + 50)
                    if (skyArea.contains(recognizerView.center)){
                UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: { recognizerView.center = originalCenter}, completion: nil)
                
                        
            
        }
    
           /* else {
                if let recognizerView = recognizer.view {
                    let translation = recognizer.translation(in: parentView)
                    let originalCenter = recognizerView.center
                    //recognizerView.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
                
                    UIView.animate(withDuration: 2.0, delay: 0, options: .curveEaseOut, animations: { recognizerView.center = originalCenter}, completion: nil)
            }*/
    }
        }
    
    
    func checkWater(recognizer: UIPanGestureRecognizer, parentView: UIView){
        if let recognizerView = recognizer.view {
            let translation = recognizer.translation(in: parentView)
            let originalCenter = recognizerView.center
            recognizerView.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
             waterArea = CGRect(x: 0, y: self.view.frame.midY + 100, width: 600, height: self.view.frame.midY/2)
             waterArea2 = CGRect(x: 500, y: self.view.frame.midY, width: (self.view.frame.midX*0.25), height: self.view.frame.midY/2)
            
            if (waterArea.contains(recognizerView.center) || waterArea2.contains(recognizerView.center)){
                
                print("water")
            
        }
    }
    }
    func checkLand(recognizer: UIPanGestureRecognizer, parentView: UIView){
        if let recognizerView = recognizer.view {
            let translation = recognizer.translation(in: parentView)
            let originalCenter = recognizerView.center
            recognizerView.center = CGPoint(x: originalCenter.x + translation.x, y: originalCenter.y + translation.y)
             landArea = CGRect(x: self.view.frame.midX, y: self.view.frame.midY + 100, width: self.view.frame.width, height: self.view.frame.midY)
            landArea2 = CGRect(x: (self.view.frame.midX*(3/2)) , y: self.view.frame.midY, width: self.view.frame.width, height: self.view.frame.midY)
            if (landArea.contains(recognizerView.center) || landArea2.contains(recognizerView.center)){
                
                
                print("land")
            }
        }
    }

    
    
    
    
    func applyGestureTranslationToGestureView(recognizer: UIPanGestureRecognizer, parentView: UIView){
        
        if let recognizerView = recognizer.view {
            let translation = recognizer.translation(in: parentView)
            let originalCenter = recognizerView.center
            recognizerView.center = CGPoint(x:originalCenter.x + translation.x, y:originalCenter.y + translation.y)
        }
        recognizer.setTranslation(lastLocation, in: parentView)
    }
    
    
    
    
    
    
    
    
    
    func setUp(){
        if diff == "Easy"{
            for _ in 0...6{
                var rIndex = Int(arc4random_uniform(UInt32(stringArray.count)))
                levelArray += [stringArray[rIndex]]
                
                /*
            var randomIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
            levelArray += [imageArray[randomIndex]]
 */
                
            }
            var imageView1: UIImageView = UIImageView(frame: CGRect(x: 0, y: 50, width: 80, height: 100))
            var imageView2: UIImageView = UIImageView(frame: CGRect(x: 150, y: 50, width: 80, height: 100))
            var imageView3: UIImageView = UIImageView(frame: CGRect(x: 300, y: 50, width: 80, height: 100))
            var imageView4: UIImageView = UIImageView(frame: CGRect(x: 450, y: 50, width: 80, height: 100))
            var imageView5: UIImageView = UIImageView(frame: CGRect(x: 600, y: 50, width: 80, height: 100))
            var imageView6: UIImageView = UIImageView(frame: CGRect(x: 750 , y: 50, width: 80, height: 100))
            var imageView7: UIImageView = UIImageView(frame: CGRect(x: 900, y: 50, width: 80, height: 100))
            
            imageView1.image = UIImage(named:levelArray[0])
            imageView1.contentMode = .scaleAspectFit
            imageView1.isUserInteractionEnabled = true
            imageView1.backgroundColor = UIColor.clear
            imageView1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView1)
            
            
            imageView2.image = UIImage(named: levelArray[1])
            imageView2.contentMode = .scaleAspectFit
            imageView2.isUserInteractionEnabled = true
            imageView2.backgroundColor = UIColor.clear
            imageView2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView2)
            
            imageView3.image = UIImage(named:levelArray[2])
            imageView3.contentMode = .scaleAspectFit
            imageView3.isUserInteractionEnabled = true
            imageView3.backgroundColor = UIColor.clear
            imageView3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView3)

            imageView4.image = UIImage(named: levelArray[3])
            imageView4.contentMode = .scaleAspectFit
            imageView4.isUserInteractionEnabled = true
            imageView4.backgroundColor = UIColor.clear
            imageView4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView4)
            
            imageView5.image = UIImage(named:levelArray[4])
            imageView5.contentMode = .scaleAspectFit
            imageView5.isUserInteractionEnabled = true
            imageView5.backgroundColor = UIColor.clear
            imageView5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView5)

            imageView6.image = UIImage(named:levelArray[5])
            imageView6.contentMode = .scaleAspectFit
            imageView6.isUserInteractionEnabled = true
            imageView6.backgroundColor = UIColor.clear
            imageView6.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView6)

            imageView7.image = UIImage(named: levelArray[6])
            imageView7.contentMode = .scaleAspectFit
            imageView7.isUserInteractionEnabled = true
            imageView7.backgroundColor = UIColor.clear
            imageView7.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView7)


           
        }
        
        if diff == "Medium" {
            for _ in 0...8{
                var rIndex = Int(arc4random_uniform(UInt32(stringArray.count)))
                levelArray += [stringArray[rIndex]]
                
                /*
                var randomIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
                levelArray += [imageArray[randomIndex]]
 */
                
            }
            var imageView1: UIImageView = UIImageView(frame: CGRect(x: 0, y: 50, width: 80, height: 100))
            var imageView2: UIImageView = UIImageView(frame: CGRect(x: 110, y: 50, width: 80, height: 100))
            var imageView3: UIImageView = UIImageView(frame: CGRect(x: 220, y: 50, width: 80, height: 100))
            var imageView4: UIImageView = UIImageView(frame: CGRect(x: 330, y: 50, width: 80, height: 100))
            var imageView5: UIImageView = UIImageView(frame: CGRect(x: 440, y: 50, width: 80, height: 100))
            var imageView6: UIImageView = UIImageView(frame: CGRect(x: 550 , y: 50, width: 80, height: 100))
            var imageView7: UIImageView = UIImageView(frame: CGRect(x: 660, y: 50, width: 80, height: 100))
            var imageView8: UIImageView = UIImageView(frame: CGRect(x: 770 , y: 50, width: 80, height: 100))
            var imageView9: UIImageView = UIImageView(frame: CGRect(x: 880, y: 50, width: 80, height: 100))
            
            imageView1.image = UIImage(named:levelArray[0])
            imageView1.contentMode = .scaleAspectFit
            imageView1.isUserInteractionEnabled = true
            imageView1.backgroundColor = UIColor.clear
            imageView1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView1)
            
            
            imageView2.image = UIImage(named:levelArray[1])
            imageView2.contentMode = .scaleAspectFit
            imageView2.isUserInteractionEnabled = true
            imageView2.backgroundColor = UIColor.clear
            imageView2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView2)
            
            imageView3.image = UIImage(named:levelArray[2])
            imageView3.contentMode = .scaleAspectFit
            imageView3.isUserInteractionEnabled = true
            imageView3.backgroundColor = UIColor.clear
            imageView3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView3)
            
            imageView4.image = UIImage(named:levelArray[3])
            imageView4.contentMode = .scaleAspectFit
            imageView4.isUserInteractionEnabled = true
            imageView4.backgroundColor = UIColor.clear
            imageView4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView4)
            
            imageView5.image = UIImage(named:levelArray[4])
            imageView5.contentMode = .scaleAspectFit
            imageView5.isUserInteractionEnabled = true
            imageView5.backgroundColor = UIColor.clear
            imageView5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView5)
            
            imageView6.image = UIImage(named:levelArray[5])
            imageView6.contentMode = .scaleAspectFit
            imageView6.isUserInteractionEnabled = true
            imageView6.backgroundColor = UIColor.clear
            imageView6.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView6)
            
            imageView7.image = UIImage(named:levelArray[6])
            imageView7.contentMode = .scaleAspectFit
            imageView7.isUserInteractionEnabled = true
            imageView7.backgroundColor = UIColor.clear
            imageView7.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView7)
            
            imageView8.image = UIImage(named:levelArray[7])
            imageView8.contentMode = .scaleAspectFit
            imageView8.isUserInteractionEnabled = true
            imageView8.backgroundColor = UIColor.clear
            imageView8.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView8)
            
            imageView9.image = UIImage(named:levelArray[8])
            imageView9.contentMode = .scaleAspectFit
            imageView9.isUserInteractionEnabled = true
            imageView9.backgroundColor = UIColor.clear
            imageView9.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView9)

            }

        
        
        if diff == "Hard"{
            for _ in 0...10{
                
                var rIndex = Int(arc4random_uniform(UInt32(stringArray.count)))
                levelArray += [stringArray[rIndex]]
                
                /*
                var randomIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
                levelArray += [imageArray[randomIndex]]
 */
                
            }
    var imageView1: UIImageView = UIImageView(frame: CGRect(x: 0, y: 50, width: 80, height: 100))
    var imageView2: UIImageView = UIImageView(frame: CGRect(x: 90, y: 50, width: 80, height: 100))
    var imageView3: UIImageView = UIImageView(frame: CGRect(x: 180, y: 50, width: 80, height: 100))
    var imageView4: UIImageView = UIImageView(frame: CGRect(x: 270, y: 50, width: 80, height: 100))
    var imageView5: UIImageView = UIImageView(frame: CGRect(x: 360, y: 50, width: 80, height: 100))
    var imageView6: UIImageView = UIImageView(frame: CGRect(x: 450 , y: 50, width: 80, height: 100))
    var imageView7: UIImageView = UIImageView(frame: CGRect(x: 540, y: 50, width: 80, height: 100))
    var imageView8: UIImageView = UIImageView(frame: CGRect(x: 630, y: 50, width: 80, height: 100))
    var imageView9: UIImageView = UIImageView(frame: CGRect(x: 720, y: 50, width: 80, height: 100))
    var imageView10: UIImageView = UIImageView(frame: CGRect(x: 810 , y: 50, width: 80, height: 100))
    var imageView11: UIImageView = UIImageView(frame: CGRect(x: 900, y: 50, width: 80, height: 100))
    
    imageView1.image = UIImage(named:levelArray[0])
    imageView1.contentMode = .scaleAspectFit
    imageView1.isUserInteractionEnabled = true
    imageView1.backgroundColor = UIColor.clear
    imageView1.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
    self.view.addSubview(imageView1)
    
    
    imageView2.image = UIImage(named:levelArray[1])
    imageView2.contentMode = .scaleAspectFit
    imageView2.isUserInteractionEnabled = true
    imageView2.backgroundColor = UIColor.clear
    imageView2.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
    self.view.addSubview(imageView2)
    
    imageView3.image = UIImage(named:levelArray[2])
    imageView3.contentMode = .scaleAspectFit
    imageView3.isUserInteractionEnabled = true
    imageView3.backgroundColor = UIColor.clear
    imageView3.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
    self.view.addSubview(imageView3)
    
    imageView4.image = UIImage(named:levelArray[3])
    imageView4.contentMode = .scaleAspectFit
    imageView4.isUserInteractionEnabled = true
    imageView4.backgroundColor = UIColor.clear
    imageView4.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
    self.view.addSubview(imageView4)
    
    imageView5.image = UIImage(named:levelArray[4])
    imageView5.contentMode = .scaleAspectFit
    imageView5.isUserInteractionEnabled = true
    imageView5.backgroundColor = UIColor.clear
    imageView5.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
    self.view.addSubview(imageView5)
    
    imageView6.image = UIImage(named:levelArray[5])
    imageView6.contentMode = .scaleAspectFit
    imageView6.isUserInteractionEnabled = true
    imageView6.backgroundColor = UIColor.clear
    imageView6.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
    self.view.addSubview(imageView6)
    
    imageView7.image = UIImage(named:levelArray[6])
    imageView7.contentMode = .scaleAspectFit
    imageView7.isUserInteractionEnabled = true
    imageView7.backgroundColor = UIColor.clear
    imageView7.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
    self.view.addSubview(imageView7)
    
            imageView8.image = UIImage(named:levelArray[7])
            imageView8.contentMode = .scaleAspectFit
            imageView8.isUserInteractionEnabled = true
            imageView8.backgroundColor = UIColor.clear
            imageView8.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView8)
            
            imageView9.image = UIImage(named:levelArray[8])
            imageView9.contentMode = .scaleAspectFit
            imageView9.isUserInteractionEnabled = true
            imageView9.backgroundColor = UIColor.clear
            imageView9.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView9)
            
            imageView10.image = UIImage(named:levelArray[9])
            imageView10.contentMode = .scaleAspectFit
            imageView10.isUserInteractionEnabled = true
            imageView10.backgroundColor = UIColor.clear
            imageView10.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView10)
            
            imageView11.image = UIImage(named:levelArray[10])
            imageView11.contentMode = .scaleAspectFit
            imageView11.isUserInteractionEnabled = true
            imageView11.backgroundColor = UIColor.clear
            imageView11.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(SortingViewController.handlePan(panGesture:))))
            self.view.addSubview(imageView11)
        
    }
    
    }


}
