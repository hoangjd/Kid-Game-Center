//
//  SortingViewController.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/21/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import UIKit

class SortingViewController: UIViewController {
    
    let minutes = UIImageView(frame: CGRect(x:165, y:720, width: 20, height: 30))
    let seconds = UIImageView(frame: CGRect(x:200, y:720, width: 20, height: 30))
    let seconds2 = UIImageView(frame: CGRect(x:230, y:720, width: 20, height: 30))
    let score1Img = UIImageView(frame: CGRect(x:895, y:720, width: 20, height: 30))
    let score2Img = UIImageView(frame: CGRect(x:925, y:720, width: 20, height: 30))
    
    let airSpace = UIView(frame: CGRect(x:0, y:150, width: 1024, height: 317))
    let landSpace1 = UIView(frame: CGRect(x: 750, y:467, width: 274, height:158))
    let landSpace2 = UIView(frame: CGRect(x: 500, y:625, width: 524, height:143))
    let waterSpace1 = UIView(frame: CGRect(x: 0, y:467, width: 750, height:158))
    let waterSpace2 = UIView(frame: CGRect(x: 0, y:625, width: 500, height:143))
    
    var moveImg = [UIPanGestureRecognizer]()
    var ourDifficulty = GameAndDifficulty()
    var getOurVehicles = AllVehicles(difficulty: "")
    var time = Time(seconds: 0)
    var originalLocations = [CGPoint]()
    var singleVehicleImage: UIImage!
    var alreadySolved: [Bool]!
    
    var scoreTimer = Timer()
    var scoreSeconds = 0
    var finalScore = 0
    var highScoreList: [[HighScore]]!
    var sortHighScore: [HighScore]!
    
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
        UIImage(named: "cartoon-number-9")!,
        ]
    
    var airArrayImage: [UIImage] = [
        UIImage(named:"1-1")!,
        UIImage(named:"1-2")!,
        UIImage(named:"1-3")!,
        UIImage(named:"1-4")!,
        UIImage(named:"1-5")!]
    
    var waterArrayImage: [UIImage] = [
        UIImage(named:"2-1")!,
        UIImage(named:"2-2")!,
        UIImage(named:"2-3")!,
        UIImage(named:"2-4")!,
        UIImage(named:"2-5")!]
    
    var landArrayImage: [UIImage] = [
        UIImage(named:"3-1")!,
        UIImage(named:"3-2")!,
        UIImage(named:"3-3")!,
        UIImage(named:"3-4")!,
        UIImage(named:"3-5")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        finalScore = 0
        sortHighScore = highScoreList[1]
        getOurVehicles = AllVehicles(difficulty: ourDifficulty.difficulty!)
        self.moveImg = [UIPanGestureRecognizer](repeatElement(UIPanGestureRecognizer(target: self, action: #selector(letsMove)), count: getOurVehicles.allArray.count))
        
        alreadySolved = [Bool](repeatElement(false, count: getOurVehicles.allArray.count))
        setUpMoveArray()
        startTime()
        addBackgroundImage()
        addSortingBar()
        timeUI()
        scoreUI()
        setUpVehicles()
        


        // Do any additional setup after loading the view.
    }
    
    func setUpMoveArray(){
        for i in 0..<getOurVehicles.allArray.count {
            moveImg[i] = UIPanGestureRecognizer(target: self, action: #selector(letsMove))
        }
    }
    
    func addBackgroundImage() {
        let background = UIImageView(frame: CGRect(x: 0, y: 75, width: 1024, height: 693))
        background.contentMode = .scaleAspectFill
        background.image = UIImage(named:"air-land-water")
        self.view.addSubview(background)
    }
    
    func addSortingBar() {
        let background = UIView(frame: CGRect(x: 0, y: 0, width: 1024, height: 150))
        background.backgroundColor = UIColor(red: 153/255, green: 204/255, blue: 250/255, alpha: 1)
        self.view.addSubview(background)
    }
    
    func timeUI() {
        let timeSpace = UIImageView(frame: CGRect(x: 75,y: 720,width: 50,height: 30 ))
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
        let scoreSpace = UIImageView(frame: CGRect(x:775, y: 720, width: 80, height: 30))
        scoreSpace.contentMode = .scaleAspectFill
        scoreSpace.image = UIImage(named:"score")
        self.view.addSubview(scoreSpace)
        
        score1Img.contentMode = .scaleAspectFill
        score1Img.image = numberImageArray[0]
        self.view.addSubview(score1Img)
        
        score2Img.contentMode = .scaleAspectFill
        score2Img.image = numberImageArray[0]
        self.view.addSubview(score2Img)
        

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
            presentLossAlert()
        }
    }
    
    @objc func updateScoreTime() {
        scoreSeconds = scoreSeconds + 1
    }
    
      @objc func letsMove(_ sender: UIPanGestureRecognizer) {

        let imageView = sender.view!

        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: imageView, sender: sender)
        case .ended:
            checkForCorrectPlacement(view: imageView, sender: sender)
        default:
            break
        }
    }
    
    func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        var point = sender.translation(in: self.view)
        view.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    func checkForCorrectPlacement(view: UIView, sender: UIPanGestureRecognizer) {
        for i in 0 ..< moveImg.count {
            if moveImg[i] == sender {
                //check for vehicle type
                if getOurVehicles.allArray[i].isAir {
                    if view.frame.intersects(airSpace.frame) {
                        canOnlySolveOnce(index: i)
                    } else {
                        returnViewToOrigin(index: i, view: view)
                    }
                } else if getOurVehicles.allArray[i].isWater {
                    if view.frame.intersects(waterSpace1.frame) || view.frame.intersects(waterSpace2.frame) {
                        canOnlySolveOnce(index: i)
                    } else {
                        returnViewToOrigin(index: i, view: view)
                    }
                } else if getOurVehicles.allArray[i].isLand {
                    if view.frame.intersects(landSpace1.frame) || view.frame.intersects(landSpace2.frame){
                        canOnlySolveOnce(index: i)
                    } else {
                        returnViewToOrigin(index: i, view: view)
                    }
                }
            }
        }
    }
    
    
    func returnViewToOrigin(index: Int, view: UIView) {
        UIView.animate(withDuration: 1, animations: {
            view.frame.origin = self.originalLocations[index]})
    }
    
    func solvedPointValue(){
        if scoreSeconds <= 2 {
            finalScore += 5
        } else if scoreSeconds > 2 && scoreSeconds <= 4{
            finalScore += 4
        } else {
            finalScore += 3
        }
        scoreSeconds = 0
    }
    
    func canOnlySolveOnce(index: Int) {
        if !alreadySolved[index] {
            alreadySolved[index] = true
            solvedPointValue()
            updateScoreUI()
            checkIfSolved()
        } else {
            return
        }
    }
    
    func updateScoreUI() {
        score1Img.image = numberImageArray[finalScore / 10]
        score2Img.image = numberImageArray[finalScore % 10]
    }
    
    func checkIfSolved() {
        for i in 0..<alreadySolved.count {
            if !alreadySolved[i] {
                return
            }
        }
        scoreTimer.invalidate()
        time.timer.invalidate()
        checkHighScores()
        
        presentWinAlert()
    }
    
    func presentWinAlert() {
        let alert = AlertMessage(viewController: self, score: finalScore)
        alert.presentWinAlert()
    }
    
    func checkHighScores() {
        let potentialHS = HighScore(gameType: "Sort", score: finalScore)


     //   sortHighScore.remove(at: i)

        for i in 0..<sortHighScore.count {
            if sortHighScore[i].score < finalScore {
                sortHighScore.insert(potentialHS, at: i)
                sortHighScore.remove(at: 5)
                highScoreList[1] = sortHighScore
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
    func presentLossAlert() {
        let alert = AlertMessage(viewController: self, score: finalScore)
        alert.endTimeAlert()
    }

    
//    func presentWinAlert() {
//        let alert = UIAlertController(title: "You Win", message: "Score: \(finalScore)", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: { action in
//            _ = self.navigationController?.popViewController(animated: true)
//
//        }))
//        alert.addAction(UIAlertAction(title:"Play Again" , style: .default, handler: { action in
//            self.resetView()
//        }))
//        present(alert, animated: true, completion: nil)
//    }
//
//    func endTimeAlert() {
//        let alert = UIAlertController(title: "GAME OVER", message: "Times Up", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
//            self.resetView()
//        }))
//        alert.addAction(UIAlertAction(title: "Go Back", style: .cancel, handler: { action in
//            _ = self.navigationController?.popViewController(animated: true)
//        }))
//        present(alert, animated: true, completion: nil)
//    }

    func setUpVehicles() {
        for i in 0 ..< getOurVehicles.allArray.count {
            if ourDifficulty.difficulty == "Easy" {
                setUpVehicleImages(index: i, adjustXToDifficulty: 232)

            } else if ourDifficulty.difficulty == "Medium" {
                setUpVehicleImages(index: i, adjustXToDifficulty: 162)

            } else if ourDifficulty.difficulty == "Hard"{
                setUpVehicleImages(index: i, adjustXToDifficulty: 92)
                
            }
        }
    }
    
    func setUpVehicleImages(index: Int, adjustXToDifficulty: Int) {
        let singleVehicleImage = UIImageView(frame: CGRect(x:adjustXToDifficulty + (index * 70), y:75, width: 60, height: 60))
        singleVehicleImage.contentMode = .scaleAspectFit
        singleVehicleImage.image = checkTypeAndReturnImage(vehicle: getOurVehicles.allArray[index])
        singleVehicleImage.isUserInteractionEnabled = true
        singleVehicleImage.addGestureRecognizer(moveImg[index])
        self.view.addSubview(singleVehicleImage)
        originalLocations.append(singleVehicleImage.frame.origin)
    }
    
    func checkTypeAndReturnImage(vehicle: SingleVehicle) -> UIImage {
        if vehicle.isAir {
            return airArrayImage[vehicle.typeIdentifier!]
        } else if vehicle.isWater {
            return waterArrayImage[vehicle.typeIdentifier!]
        } else {
            return landArrayImage[vehicle.typeIdentifier!]
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
////        if let readAllHighScores = UserDefaults.standard.object(forKey: "allScores") as? Data {
////            allHighScores = NSKeyedUnarchiver.unarchiveObject(with: readAllHighScores) as! [[HighScore]]
////        }
//    }
    


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

//extension UIViewController {
//    func resetView() {
//        let parent = view.superview
//        view.removeFromSuperview()
//        view = nil
//        parent?.addSubview(view)
//    }
//}

