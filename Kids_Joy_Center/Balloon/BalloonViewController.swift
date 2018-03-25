//
//  BalloonViewController.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/21/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import UIKit

class BalloonViewController: UIViewController {
    
    let minutes = UIImageView(frame: CGRect(x:140, y:75, width: 20, height: 30))
    let seconds = UIImageView(frame: CGRect(x:180, y:75, width: 20, height: 30))
    let seconds2 = UIImageView(frame: CGRect(x:210, y:75, width: 20, height: 30))
    let score1Img = UIImageView(frame: CGRect(x:895, y:75, width: 20, height: 30))
    let score2Img = UIImageView(frame: CGRect(x:925, y:75, width: 20, height: 30))
    let score3Img = UIImageView(frame: CGRect(x:955, y:75, width: 20, height: 30))
    let score4Img = UIImageView(frame: CGRect(x:985, y:75, width: 20, height: 30))
    
    var ourDifficulty = GameAndDifficulty()
    var balloonViews = [UIImageView]()
    var numberViews = [UIImageView]()
    var time = Time(seconds: 0)
    
    var balloonTimer = Timer()
    var balloonTimerSeconds = 0
    var balloonIsBeingUsed = [Bool](repeatElement(false, count: 10))
    var balloonCatcherTimer = [Timer](repeatElement(Timer(), count: 10))
    var balloonCatcherSeconds = [Float](repeatElement(0.0, count: 10))
    var balloonCatcherView = [CGRect](repeatElement(CGRect(x:0, y:0, width: 0, height: 0), count: 10))
    
    var balloonValue = [Int](repeatElement(0, count: 10))
    var scoreTimer = Timer()
    var scoreSeconds = 0
    var finalScore = 0
    var highScoreList: [[HighScore]]!
    var balloonHighScore: [HighScore]!
    
    var pop: UITapGestureRecognizer!
    
    let numberImageArray: [UIImage] = [
        UIImage(named: "cartoon-number-0")!,
        UIImage(named: "cartoon-number-1")!,
        UIImage(named: "cartoon-number-2")!,
        UIImage(named: "cartoon-number-3")!,
        UIImage(named: "cartoon-number-4")!,
        UIImage(named: "cartoon-number-5")!,
        UIImage(named: "cartoon-number-6")!,
        UIImage(named: "cartoon-number-7")!,
        UIImage(named: "cartoon-number-8")!,
        UIImage(named: "cartoon-number-9")!,]
    
    var balloonImage: [UIImage] = [
        UIImage(named:"color1")!,
        UIImage(named:"color2")!,
        UIImage(named:"color3")!,
        UIImage(named:"color4")!,
        UIImage(named:"color5")!,
        UIImage(named:"color6")!,
        UIImage(named:"color7")!,
        UIImage(named:"color8")!,
        UIImage(named:"color9")!,
        UIImage(named:"color10")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        balloonHighScore = highScoreList[2]
        addBackgroundImage()
        timeUI()
        scoreUI()
        setUp10Locations()
        startTime()
        createPopAnim()
    //    createPopAnim()
        // Do any additional setup after loading the view.
    }
    
    func addBackgroundImage() {
        let background = UIImageView(frame: CGRect(x: 0, y: 0, width: 1024, height: 768))
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named:"sky-background")
        self.view.addSubview(background)
    }
    
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
    func scoreUI(){
        let scoreSpace = UIImageView(frame: CGRect(x:775, y: 75, width: 80, height: 30))
        scoreSpace.contentMode = .scaleAspectFill
        scoreSpace.image = UIImage(named:"score")
        self.view.addSubview(scoreSpace)
        
        score1Img.contentMode = .scaleAspectFill
        score2Img.contentMode = .scaleAspectFill
        score3Img.contentMode = .scaleAspectFill
        score4Img.contentMode = .scaleAspectFill
        
        
        score1Img.image = numberImageArray[finalScore / 100]
        score2Img.image = numberImageArray[finalScore % 100]
        score3Img.image = numberImageArray[finalScore / 10]
        score4Img.image = numberImageArray[finalScore % 10]
        
        self.view.addSubview(score1Img)
        self.view.addSubview(score2Img)
        self.view.addSubview(score3Img)
        self.view.addSubview(score4Img)
        
    }
    
    func setUp10Locations() {
        for i in 0..<10 {
            let balloonSpace = UIImageView(frame: CGRect(x:20 + (100*i), y: 800, width: 80, height: 80))
            let numberSpace = UIImageView(frame: CGRect(x:25, y:20, width: 30, height: 40))
            
//            balloonSpace.backgroundColor = UIColor.black
//            numberSpace.backgroundColor = UIColor.red
            
 //           createPopAnim(balloon: balloonSpace)
            self.view.addSubview(balloonSpace)
            balloonSpace.addSubview(numberSpace)
            numberViews.append(numberSpace)
            balloonViews.append(balloonSpace)
            
        }
    }
    
    func startTime() {
        time = setUpTimer()
        time.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(BalloonViewController.updateTimeImages)), userInfo: nil, repeats: true)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(BalloonViewController.updateScoreTime)), userInfo: nil, repeats: true)
        balloonTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(BalloonViewController.balloonRand)), userInfo: nil, repeats: true)
    }
    
    func setUpTimer() -> Time {
        var ourTime: Time
        if ourDifficulty.difficulty == "Easy"{
            ourTime = Time(seconds: 60)
        } else if ourDifficulty.difficulty == "Medium"{
            ourTime = Time(seconds: 45)
        } else {
            ourTime = Time(seconds:30)
        }
        return ourTime
    }
    
    @objc func updateTimeImages() {
        if time.seconds > 0{
            time.updateImages(time: TimeInterval(time.seconds))
            minutes.image = time.minImg
            seconds.image = time.secondImg
            seconds2.image = time.second2Img
            
            time.seconds -= 1
        } else {
            time.updateImages(time: TimeInterval(time.seconds))
            seconds2.image = time.second2Img
            time.timer.invalidate()
        //    presentLossAlert()
        }
    }
    
    func createPopAnim() {
        self.view.isUserInteractionEnabled = true
        //  view.backgroundColor = UIColor.black
        pop = UITapGestureRecognizer(target: self, action: (#selector(popBalloon(sender:))))
        //  view.addGestureRecognizer(pop)
        self.view.addGestureRecognizer(pop)
    }
    
    @objc func popBalloon(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)

        for i in 0..<10 {

            //if user clicks on balloon
            if balloonCatcherView[i].contains(point){
                finalScore += balloonValue[i]
                
                balloonViews[i].layer.removeAllAnimations()
                balloonCatcherView[i] = CGRect(x: 0, y: 0, width: 0, height: 0)
                
                scoreSeconds = 0
                updateScoreUI()
            }
        }
    }
    

    
    @objc func balloonRand() {
        balloonTimerSeconds += 1
        
        checkTimer()
        var randLocation = Int(arc4random_uniform(10))
        var randBalloon = Int(arc4random_uniform(10))
        
        while balloonIsBeingUsed[randLocation]{
            randLocation = Int(arc4random_uniform(10))
        }
        let balloonImageView = balloonViews[randLocation]
        let numberImageView = numberViews[randLocation]

        var i = 0
        
        balloonImageView.image = balloonImage[randBalloon]
        numberImageView.image = numberImageArray[randBalloon]
        
        balloonValue[randLocation] = randBalloon

        balloonCatcherTimer[randLocation] = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(BalloonViewController.updateFrameLoc(sender:))), userInfo: randLocation, repeats: true)
        
        
        animateUp(balloonImageView: balloonImageView, randLocation: randLocation)

    }
    
    func animateUp(balloonImageView: UIView, randLocation: Int) {
        UIView.animate(withDuration: 9,
                       delay: 0,
                       animations: {
                        self.balloonIsBeingUsed[randLocation] = true
                        balloonImageView.frame.origin.y = -100
        },
                       completion: {(finished: Bool) in
                        balloonImageView.frame.origin.y = 800
                        self.balloonCatcherTimer[randLocation].invalidate()
                        self.balloonIsBeingUsed[randLocation] = false
        })
        
    }
    
    func checkTimer() {
        if time.seconds == 0 {
        endGame()
        checkHighScores()
        lossAlert(why: "Out Of Time!")
        
        }
    }
    
    func checkHighScores() {
        let potentialHS = HighScore(gameType: "Sort", score: finalScore)
        
        
        //   sortHighScore.remove(at: i)
        
        for i in 0..<balloonHighScore.count {
            if balloonHighScore[i].score < finalScore {
                balloonHighScore.insert(potentialHS, at: i)
                balloonHighScore.remove(at: 5)
                highScoreList[2] = balloonHighScore
                //       sortHighScore[i].score = finalScore
                updateDatabase()
                return
            }
            
        }
    }

    func updateDatabase(){
        let highScoreData = NSKeyedArchiver.archivedData(withRootObject: highScoreList)
        UserDefaults.standard.set(highScoreData, forKey: "allScores")
        UserDefaults.standard.synchronize()
    }

    @objc func updateFrameLoc(sender: Timer) {
        switch sender.userInfo as! Int {
        case 0:
            balloonCatcherView[0] = balloonViews[0].layer.presentation()!.frame
            break
        case 1:
             balloonCatcherView[1] = balloonViews[1].layer.presentation()!.frame
            break
        case 2:
             balloonCatcherView[2] = balloonViews[2].layer.presentation()!.frame
            break
        case 3:
             balloonCatcherView[3] = balloonViews[3].layer.presentation()!.frame
               break
        case 4:
             balloonCatcherView[4] = balloonViews[4].layer.presentation()!.frame
               break
        case 5:
             balloonCatcherView[5] = balloonViews[5].layer.presentation()!.frame
               break
        case 6:
            balloonCatcherView[6] = balloonViews[6].layer.presentation()!.frame
               break
        case 7:
            balloonCatcherView[7] = balloonViews[7].layer.presentation()!.frame
               break
        case 8:
            balloonCatcherView[8] = balloonViews[8].layer.presentation()!.frame
               break
        case 9:
            balloonCatcherView[9] = balloonViews[9].layer.presentation()!.frame
               break
        default:
               break
        }
//        print(balloonCatcherView[0])
    }
    



    @objc func updateScoreTime() {
        scoreSeconds = scoreSeconds + 1
        
        if scoreSeconds == 10 {
            endGame()
            checkHighScores()
            lossAlert(why: "10 Seconds without popping!")

        }
    }
    
    func updateScoreUI() {
        score1Img.image = numberImageArray[finalScore / 1000 % 10]
        score2Img.image = numberImageArray[finalScore / 100 % 10]
        score3Img.image = numberImageArray[finalScore / 10 % 10]
        score4Img.image = numberImageArray[finalScore % 10]
    }
    
    func endTimeAlert() {
        let alert = UIAlertController(title: "GAME OVER", message: "Times UP Score \(finalScore)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            self.resetView()
        }))
        alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: { action in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func lossAlert(why: String) {
        let alert = UIAlertController(title: why, message: " Score: \(finalScore)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            self.resetView()
        }))
        alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: { action in
            _ = self.navigationController?.popViewController(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func endGame(){
        time.timer.invalidate()
        scoreTimer.invalidate()
        balloonTimer.invalidate()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
    //    balloonCatcherTimer.invalidate()
        endGame()
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
