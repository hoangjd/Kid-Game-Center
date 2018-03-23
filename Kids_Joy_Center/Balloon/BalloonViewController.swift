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
    
    var ourDifficulty = GameAndDifficulty()
    var balloonViews = [UIImageView]()
    var time = Time(seconds: 0)
    
    var scoreTimer = Timer()
    var scoreSeconds = 0
    var finalScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundImage()
        timeUI()
        scoreUI()
        setUp10Locations()
        startTime()
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
    }
    
    func setUp10Locations() {
        for i in 0..<10 {
            let balloonSpace = UIView(frame: CGRect(x:20 + (100*i), y: 700, width: 80, height: 80))
            balloonSpace.backgroundColor = UIColor.black
            self.view.addSubview(balloonSpace)
        }
    }
    
    func startTime() {
        time = setUpTimer()
        time.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SortingViewController.updateTimeImages)), userInfo: nil, repeats: true)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SortingViewController.updateScoreTime)), userInfo: nil, repeats: true)
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
    
    @objc func updateScoreTime() {
        scoreSeconds = scoreSeconds + 1
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
