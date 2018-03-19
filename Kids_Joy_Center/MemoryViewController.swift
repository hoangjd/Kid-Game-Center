//
//  MemoryViewController.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/16/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
    
    class MatchCoordinates {
        var row: Int?
        var col: Int?
    
        func clearCoordinates() {
            self.row = nil
            self.col = nil
        }
    }
    
    
    
    var ourDifficulty = GameAndDifficulty()
    var createBoardValues = AllMemoryCards(difficulty: "")
    var buttonArray = [[UIButton]]()
    var possibleMatch = MatchCoordinates()
    var time = Time(seconds: 0)
    let minutes = UIImageView(frame: CGRect(x:140, y:75, width: 20, height: 30))
    let seconds = UIImageView(frame: CGRect(x:180, y:75, width: 20, height: 30))
    let seconds2 = UIImageView(frame: CGRect(x:210, y:75, width: 20, height: 30))
    var secondTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"background")!)\

        startTime()
        createBoardValues = AllMemoryCards(difficulty: ourDifficulty.difficulty!)
        buildBackground()
        buildBoardView()
        timeUI()
        scoreUI()
        

        // Do any additional setup after loading the view.
    }
    
    func startTime() {
        time = setUpTimer()
        secondTimer = time.timer
        secondTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MemoryViewController.updateTimeImages)), userInfo: nil, repeats: true)
        time.startTime()
    }
    
    func setUpTimer() -> Time {
        var ourTime: Time
        if ourDifficulty.difficulty == "Easy"{
            ourTime = Time(seconds: 120)
        } else if ourDifficulty.difficulty == "Medium"{
            ourTime = Time(seconds: 105)
        } else {
            ourTime = Time(seconds:90)
        }
        return ourTime
    }
    
    //create background image
    func buildBackground(){
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        background.contentMode = .scaleAspectFill
        let backgroundImg = UIImage(named: "background")!
        background.image = backgroundImg
        self.view.addSubview(background)
    }
    //build view for cards
    func buildBoardView() {
        let boardSpace = UIView(frame: CGRect(x: 106, y: 150, width: 800, height: 550))
        self.view.addSubview(boardSpace)
        individualCardsUI(board: boardSpace)
    }
    //create time ui
    func timeUI() {
        let timeSpace = UIImageView(frame: CGRect(x: 50,y: 75,width: 50,height: 30 ))
        timeSpace.contentMode = .scaleAspectFill
        let image : UIImage = UIImage(named: "time")!
        timeSpace.image = image
        self.view.addSubview(timeSpace)
        
        minutes.contentMode = .scaleAspectFill
        minutes.image = time.minImg
        self.view.addSubview(minutes)
        
        seconds.contentMode = .scaleAspectFill
        seconds.image = time.secondImg
        self.view.addSubview(seconds)
        
        seconds2.contentMode = .scaleAspectFill
        seconds2.image = time.second2Img
        self.view.addSubview(seconds2)
        
    }
    //update numbers based on time
    @objc func updateTimeImages(){
        minutes.image = time.minImg
        seconds.image = time.secondImg
        seconds2.image = time.second2Img
        
        if time.seconds == 0 {
            minutes.image = time.minImg
            seconds.image = time.secondImg
            seconds2.image = time.second2Img
            secondTimer.invalidate()
            let alert = UIAlertController(title: "GAME OVER", message: "Times UP", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    // creates score ui
    func scoreUI(){
        let scoreSpace = UIImageView(frame: CGRect(x:775, y: 75, width: 80, height: 30))
        scoreSpace.contentMode = .scaleAspectFill
        scoreSpace.image = UIImage(named:"score")
        self.view.addSubview(scoreSpace)
    }
    // create all of the cards
    func individualCardsUI(board: UIView) {
        let row = createBoardValues.arrayOfCards.count
        let col = createBoardValues.arrayOfCards[0].count
        for i in 0..<row {
            var singleButtonRow = [UIButton]()
            for j in 0..<col {
                var card: UIButton
                if ourDifficulty.difficulty == "Easy" {
                    card = UIButton(frame: CGRect(x: 198 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                } else if ourDifficulty.difficulty == "Medium" {
                    card = UIButton(frame: CGRect(x: 133 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                } else if ourDifficulty.difficulty == "Hard" {
                    card = UIButton(frame: CGRect(x: 67 + (135*j), y: 5 + (135*i), width: 125, height: 125))
                } else {
                    print("Error in individualCardsUI")
                    return
                }
                card.setBackgroundImage(UIImage(named: "question"), for: .normal)
                card.addTarget(self, action: #selector(flipCard), for: .touchUpInside)
                singleButtonRow.append(card)
                board.addSubview(card)
            }
            buttonArray.append(singleButtonRow)
        }
    }
    
    @objc func flipCard(sender: UIButton) {
        let row = createBoardValues.arrayOfCards.count
        let col = createBoardValues.arrayOfCards[0].count
        
        for i in 0..<row {
            for j in 0..<col {
                if sender == buttonArray[i][j] {
                    sender.setBackgroundImage(UIImage(named: "\(createBoardValues.arrayOfCards[i][j].image!)"), for: .normal)
                    checkMatch(row: i, col: j)
                }
            }
        }
    }
    
    func checkMatch(row: Int, col: Int) {
        let storeCoordinates = MatchCoordinates()
        storeCoordinates.row = row
        storeCoordinates.col = col
        if possibleMatch.row == nil {
         //   var storeCoordinates = MatchCoordinates()
            possibleMatch = storeCoordinates
            return
        }
        else {
            let matchRow = possibleMatch.row
            let matchCol = possibleMatch.col
            if createBoardValues.arrayOfCards[matchRow!][matchCol!].cardIdentifier == createBoardValues.arrayOfCards[row][col].cardIdentifier {
                possibleMatch.clearCoordinates()
                return
            } else {
                buttonArray[matchRow!][matchCol!].setBackgroundImage(UIImage(named:"question"), for: .normal)
                buttonArray[row][col].setBackgroundImage(UIImage(named:"question"), for: .normal)
                possibleMatch.clearCoordinates()
                return
            }
        }
    }
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil {
             time.timer.invalidate()
        }
    }

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
