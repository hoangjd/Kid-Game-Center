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
    var numberViews = [UIImageView]()
    var time = Time(seconds: 0)
    
    var balloonTimer = Timer()
    var balloonIsBeingUsed = [Bool](repeatElement(false, count: 10))
    var balloonCatcherTimer = [Timer](repeatElement(Timer(), count: 10))
    var balloonCatcherSeconds = [Float](repeatElement(0.0, count: 10))
    var balloonCatcherView = [CGRect](repeatElement(CGRect(x:0, y:0, width: 0, height: 0), count: 10))
    
    var scoreTimer = Timer()
    var scoreSeconds = 0
    var finalScore = 0
    var highScoreList: [[HighScore]]!
    
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
    
//    func createPopAnim(view: UIView) {
//        view.isUserInteractionEnabled = true
//      //  view.backgroundColor = UIColor.black
//        pop = UITapGestureRecognizer(target: self, action: (#selector(popBalloon(sender:))))
//      //  view.addGestureRecognizer(pop)
//        self.view.addGestureRecognizer(pop)
//    }
    
    func createPopAnim() {
        self.view.isUserInteractionEnabled = true
        //  view.backgroundColor = UIColor.black
        pop = UITapGestureRecognizer(target: self, action: (#selector(popBalloon(sender:))))
        //  view.addGestureRecognizer(pop)
        self.view.addGestureRecognizer(pop)
    }
    
    @objc func popBalloon(sender: UITapGestureRecognizer) {
        let point = sender.location(in: self.view)
 //       let val = balloonCatcherView[0]
        for i in 0..<10 {
    //        val = balloonCatcherView[0].frame
            if balloonCatcherView[i].contains(point){
                print("pop \(point)")
            }
        }
    }
    
    @objc func balloonRand() {
        var randLocation = Int(arc4random_uniform(10))
        var randBalloon = Int(arc4random_uniform(10))
        
        while balloonIsBeingUsed[randLocation]{
            randLocation = Int(arc4random_uniform(10))
        }
        let balloonImageView = balloonViews[randLocation]
        let numberImageView = numberViews[randLocation]
 //       let originalLoc = CGRect(x: balloonViews[randLocation].frame.origin.x + self.view.frame.origin.x, y: 700, width: 80, height: 80)
//        let newLoc = CGRect(x: balloonViews[randLocation].frame.origin.x + self.view.frame.origin.x, y: -100, width: 80, height: 80)
        var i = 0
        
        balloonImageView.image = balloonImage[randBalloon]
        numberImageView.image = numberImageArray[randBalloon]
        
    //    createPopAnim(balloon: balloonImageView)
        
  //      while balloonImageView.frame.origin.y > -100 && i < 50{
        //    print (balloonImageView.frame.origin.y)
  //          print (i)
        
//        let loc = balloonImageView.layer.presentation()?.frame.origin.y
        balloonCatcherTimer[randLocation] = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: (#selector(BalloonViewController.updateFrameLoc(sender:))), userInfo: randLocation, repeats: true)
            UIView.animate(withDuration: 9,
                           delay: 0,
                           options: [.allowUserInteraction, .allowAnimatedContent],
                           animations: {
                            self.balloonIsBeingUsed[randLocation] = true
//                                balloonImageView.frame.origin.y = balloonImageView.frame.origin.y - CGFloat(i)
                                balloonImageView.frame.origin.y = -100
          //                      balloonImageView.frame.origin.y = balloonImageView.layer.presentation()!.frame.origin.y
                //            print(loc)
                            },
                           completion: {(finished: Bool) in
                            balloonImageView.frame.origin.y = 800
               //             print(loc)
                            self.balloonCatcherTimer[randLocation].invalidate()
                            self.balloonIsBeingUsed[randLocation] = false
            })

 //           i += 1
  //      }
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
    
//    @objc func updateFrameLoc(sender:Timer) {
//        for i in 0..<balloonCatcherTimer.count {
//            if sender == balloonCatcherTimer[i]{
//                balloonCatcherView[i].frame = balloonViews[i].layer.presentation()!.frame
//                print(balloonCatcherView[0].frame)
//           //     createPopAnim(view: balloonCatcherView[i])
//     //           print ("\(balloonViews[i].layer.presentation()!.frame) \(i)")
//
//            }
//        }
//    }


    @objc func updateScoreTime() {
        scoreSeconds = scoreSeconds + 1
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    //    balloonCatcherTimer.invalidate()
        time.timer.invalidate()
        scoreTimer.invalidate()
        balloonTimer.invalidate()
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
