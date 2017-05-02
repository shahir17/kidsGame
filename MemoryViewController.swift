//
//  MemoryViewController.swift
//  Kid Joy Center
//
//  Created by Shahir Abdul-Satar on 3/18/17.
//  Copyright © 2017 Ahmad Shahir Abdul-Satar. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIGestureRecognizerDelegate{
    
    
    var gameName = "Memory Game"
    var vc : ViewController = ViewController()
    var diff = ""
    var countDownLabel: UILabel!
    var seconds = 60
    var easyImages: Array<String> = []
     var collectionView: UICollectionView!
     var items: Array<UIImage> = []
    var items2: Array<String> = []
    var timeLabel: UIImageView!
    var shuffledItems: Array<String> = []
    var mediumImages: Array<String> = []
    var hardImages: Array<String> = []
    var scoreLabel: UIImageView!
    var score: UILabel!
    var count = 0
    var easyShuffled: Array<String> = []
    var mediumShuffled: Array<String> = []
    var hardShuffled: Array<String> = []
    var first = ""
    var second = ""
    var cell: MemoryCollectionViewCell!
    var cell2: MemoryCollectionViewCell!
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
        backgroundImage.image = UIImage(named: "background")
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.
        countDownLabel = UILabel(frame: CGRect(x: 130, y: 35, width: 200, height: 100))
        countDownLabel.font = UIFont(name: countDownLabel.font.fontName, size: 28)
        self.view.addSubview(countDownLabel)
        
        navigationItem.title = "Memory Matching"
        timeLabel = UIImageView(frame: CGRect(x: 0, y: 35, width: 100, height: 100))

        timeLabel.image = UIImage(named: "time")
        timeLabel.contentMode = .scaleAspectFit
        self.view.addSubview(timeLabel)
        
        scoreLabel = UIImageView(frame: CGRect(x: 820, y: 35, width: 100, height: 100))
        scoreLabel.image = UIImage(named: "score")
        scoreLabel.contentMode = .scaleAspectFit
        self.view.addSubview(scoreLabel)
        
        score = UILabel(frame: CGRect(x: 950, y: 35, width: 200, height: 100))
        score.font = UIFont(name: score.font.fontName, size: 28)
        score.text = String(0)
        self.view.addSubview(score)
        
        var timer = Timer(timeInterval: 2.0, target: self, selector: #selector(MemoryViewController.reloadData), userInfo: nil, repeats: false)
        
        
        items += [UIImage(named: "1")!, UIImage(named: "2")!, UIImage(named: "3")!,UIImage(named: "4")!,UIImage(named: "5")!,UIImage(named: "6")!,UIImage(named: "7")!,UIImage(named: "8")!,UIImage(named: "9")!,UIImage(named: "10")!]
        
        if (diff == "Easy"){
            seconds = 120
            runTimer()
        }
        if (diff == "Medium"){
            seconds = 105
            runTimer()
        }
        if (diff == "Hard"){
            seconds = 90
            runTimer()
        }
        
        
        items2 += ["1", "2","3","4","5","6","7","8","9","10"]
        shuffledItems = items2.shuffled()
       print(shuffledItems)
        easyImages.append(shuffledItems[0])
        easyImages.append(shuffledItems[1])
        easyImages.append(shuffledItems[2])
        easyImages.append(shuffledItems[3])
        easyImages.append(shuffledItems[4])
        easyImages.append(shuffledItems[5])
        easyImages.append(shuffledItems[0])
        easyImages.append(shuffledItems[1])
        easyImages.append(shuffledItems[2])
        easyImages.append(shuffledItems[3])
        easyImages.append(shuffledItems[4])
        easyImages.append(shuffledItems[5])
        print(easyImages)
        mediumImages.append(shuffledItems[0])
        mediumImages.append(shuffledItems[1])
        mediumImages.append(shuffledItems[2])
        mediumImages.append(shuffledItems[3])
        mediumImages.append(shuffledItems[4])
        mediumImages.append(shuffledItems[5])
        mediumImages.append(shuffledItems[6])
        mediumImages.append(shuffledItems[7])
        mediumImages.append(shuffledItems[0])
        mediumImages.append(shuffledItems[1])
        mediumImages.append(shuffledItems[2])
        mediumImages.append(shuffledItems[3])
        mediumImages.append(shuffledItems[4])
        mediumImages.append(shuffledItems[5])
        mediumImages.append(shuffledItems[6])
        mediumImages.append(shuffledItems[7])

        print(mediumImages)
        hardImages.append(shuffledItems[0])
        hardImages.append(shuffledItems[1])
        hardImages.append(shuffledItems[2])
        hardImages.append(shuffledItems[3])
        hardImages.append(shuffledItems[4])
        hardImages.append(shuffledItems[5])
        hardImages.append(shuffledItems[6])
        hardImages.append(shuffledItems[7])
        hardImages.append(shuffledItems[8])
        hardImages.append(shuffledItems[9])
        hardImages.append(shuffledItems[0])
        hardImages.append(shuffledItems[1])
        hardImages.append(shuffledItems[2])
        hardImages.append(shuffledItems[3])
        hardImages.append(shuffledItems[4])
        hardImages.append(shuffledItems[5])
        hardImages.append(shuffledItems[6])
        hardImages.append(shuffledItems[7])
        hardImages.append(shuffledItems[8])
        hardImages.append(shuffledItems[9])
        print(hardImages)
        
        easyShuffled = easyImages.shuffled()
        mediumShuffled = mediumImages.shuffled()
        hardShuffled = hardImages.shuffled()
        
        
        /*
        var imageView : UIImageView
        imageView = UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        imageView.image = UIImage(named: "question")
        
        self.view.addSubview(imageView)

        imageView.contentMode = UIViewContentMode.scaleAspectFit
        
        */
        
    /*
        createTable()
        start()
        */
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 110, height: 110)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //collectionView.contentMode = UIViewContentMode.center
        collectionView.register(MemoryCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY)
        collectionView.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView)
        
        
        
    }
    
   
    
    
    override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
        
            var frame = collectionView.frame
        
            frame.size.height = self.collectionView!.frame.size.height
            frame.size.width = self.collectionView!.frame.size.width
        if (diff == "Easy"){
            frame.origin.x = CGFloat(Int(frame.size.width) / 3)
            frame.origin.y = 200
        }
        if (diff == "Medium") {
            frame.origin.x = CGFloat(Int(frame.size.width) / 4)
            frame.origin.y = 200
        }
        if (diff == "Hard"){
            frame.origin.x = CGFloat(Int(frame.size.width) / 5)
            frame.origin.y = 200
        }
        
        
            collectionView.frame = frame
    }
    
    
   

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sections = 0
        if (diff == "Easy"){
            sections = 3
        }
        if (diff == "Medium"){
            sections = 4
        }
        if (diff == "Hard"){
            sections = 5
        }
        return sections

        
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MemoryCollectionViewCell
        
        let randomIndex = Int(arc4random_uniform(UInt32(items2.count)))
        
        cell.imageView.image = UIImage(named: "question")
        cell.isUserInteractionEnabled = true
        cell.isSelected = false
        /*
        if (cell.isSelected == true && (count == 1)){
            
            cell.imageView.image = UIImage(named: easyShuffled[indexPath.section*3 + indexPath.row])
            first = easyShuffled[indexPath.section*3 + indexPath.row]
            
            print(first)
            print("count" + String(count))
        }
        if (cell.isSelected == true && (count == 2)){
            
            cell.imageView.image = UIImage(named: easyShuffled[indexPath.section*3 + indexPath.row])
            second = easyShuffled[indexPath.section*3 + indexPath.row]
            
            print(second)
            print("count" + String(count))
            collectionView.reloadData()
            if (first != second){
                
                print("NO MATCH")
                //collectionView.reloadData()
                count = 0
            }
            else {
                print(" match")
                
                count = 0
            }
            
        }*/
/*
        if cell.isSelected == true {
            cell.imageView.image = UIImage(named: easyShuffled[indexPath.section*3 + indexPath.row])
            first = easyShuffled[indexPath.section*3 + indexPath.row]

        }
        else {
            cell.imageView.image = UIImage(named: easyShuffled[indexPath.section*3 + indexPath.row])
            second = easyShuffled[indexPath.section*3 + indexPath.row]
        }*/

        
        //let tapQuestion = UITapGestureRecognizer(target: self, action: #selector(MemoryViewController.showImage))
        //tapQuestion.delegate = self
        //cell.addGestureRecognizer(tapQuestion)
        
        return cell
    }
    
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {





        first = ""
        second = ""
        if (diff == "Easy"){
            
            var cell = collectionView.cellForItem(at: indexPath) as! MemoryCollectionViewCell
            
             count += 1
           if (cell.isSelected == true && (count == 1)){
            
            cell.imageView.image = UIImage(named: easyShuffled[indexPath.section*3 + indexPath.row])
            first = easyShuffled[indexPath.section*3 + indexPath.row]
                
                print(first)
                print("count" + String(count))
            }
           if (cell.isSelected == true && (count == 2)){
            
                cell.imageView.image = UIImage(named: easyShuffled[indexPath.section*3 + indexPath.row])
                second = easyShuffled[indexPath.section*3 + indexPath.row]
            
                print(second)
                print("count" + String(count))
                collectionView.reloadData()
                if (first != second){
                    
                    print("NO MATCH")
                collectionView.reloadData()
                count = 0
                }
                else {
                    print(" match")
                    
                    count = 0
                }

            }
            
    }
    
            
        //cell.isUserInteractionEnabled = false
            
        
        if (diff == "Medium"){
            
            
                let cell = collectionView.cellForItem(at: indexPath) as! MemoryCollectionViewCell
                cell.imageView.image = UIImage(named: mediumShuffled[indexPath.section*4 + indexPath.row])
                
                
                cell.isUserInteractionEnabled = false
            
                print(indexPath.row, indexPath.section)
            

        }
        if (diff == "Hard"){
            
            
                let cell = collectionView.cellForItem(at: indexPath) as! MemoryCollectionViewCell
                cell.imageView.image = UIImage(named: hardShuffled[indexPath.section*5 + indexPath.row])
                
                
                cell.isUserInteractionEnabled = false
            
                print(indexPath.row, indexPath.section)
            

        }
        
            
        
    }
    func reloadData(){
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell2 = collectionView.cellForItem(at: indexPath) as! MemoryCollectionViewCell
        if cell2.isEqual(collectionView.cellForItem(at: indexPath)?.isSelected){
            print("Equal")
        }
    }
    
    
}



extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        for _ in 0...29 {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
            }
        }
    }
}

extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}

   

    /*
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.blue
        return cell
    }
    func makeTable() {
        collectionView.center = view.center
        collectionView.isScrollEnabled = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "itemCell")
        collectionView.backgroundColor = UIColor.clear
        self.view.addSubview(collectionView)
    }
    */
    
    
    
    
    /*
    private func start() {
        items = Array<Int>(repeating: 1, count: numItemsNeeded(difficulty: difficulty))
        collectionView.reloadData()
    }
    */
    
    
    


/*
     extension MemoryViewController {
        func createTable() {
            let space: CGFloat = 5
            let (collectionWidth, collectionHeight) = tableSizeGivenDifficulty(difficulty: difficulty, space: space)
            
            let layout = equalLayout(cardSize: itemSizeDifficulty(difficulty: difficulty, space: space), space: space)
            
            collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: collectionWidth, height: collectionHeight), collectionViewLayout: layout)
            collectionView.center = view.center
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.isScrollEnabled = false
            collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "itemCell")
            collectionView.backgroundColor = UIColor.clear
            self.view.addSubview(collectionView)
        }
        func tableSizeGivenDifficulty(difficulty: Difficulty, space: CGFloat) -> (CGFloat, CGFloat) {
            let (columns, rows) = sizeDifficulty(difficulty: difficulty)
            let (itemWidth, itemHeight) = itemSizeDifficulty(difficulty: difficulty, space: space)
            let collectionWidth = columns*(itemWidth + 2*space)
            let collectionHeight = rows*(itemHeight + space)
            return (collectionWidth, collectionHeight)
        }
        func itemSizeDifficulty(difficulty: Difficulty, space: CGFloat) -> (CGFloat, CGFloat) {
            let ratio: CGFloat = 1.452
            let (columns, rows) = sizeDifficulty(difficulty: difficulty)
            let itemHeight: CGFloat = view.frame.height/rows - 2*space
            let itemWidth: CGFloat = itemHeight/ratio
            return (itemWidth, itemHeight)
        }
        
        func equalLayout(cardSize: (itemWidth: CGFloat, itemHeight: CGFloat), space: CGFloat) -> UICollectionViewLayout {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
            layout.itemSize = CGSize(width: cardSize.itemWidth, height: cardSize.itemHeight)
            layout.minimumLineSpacing = space
            return layout
        }
    }
 extension MemoryViewController {
    func sizeDifficulty(difficulty: Difficulty) -> (CGFloat, CGFloat) {
        switch difficulty {
        case .Easy:
            return (4,3)
        case .Medium:
            return (4,4)
        case .Hard:
            return (4,5)
        }
    }
    
    func numItemsNeeded(difficulty: Difficulty) -> Int {
        let (columns, rows) = sizeDifficulty(difficulty: difficulty)
        return Int(columns * rows)
    }
}


extension MemoryViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as! UICollectionViewCell
        //cell.backgroundColor = UIImageView(UIImage(cgImage: "question"))
        cell.backgroundColor = UIColor.blue
        return cell
    }
}
extension MemoryViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
    
   */



