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
    var findSender = -1
    
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
        
        getOurVehicles = AllVehicles(difficulty: ourDifficulty.difficulty!)
     //   moveImg = UIPanGestureRecognizer(target: self, action: #selector(letsMove))
        self.moveImg = [UIPanGestureRecognizer](repeatElement(UIPanGestureRecognizer(target: self, action: #selector(letsMove)), count: getOurVehicles.allArray.count))
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
    
    func addSpaceTest() {
        airSpace.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.4)
        self.view.addSubview(airSpace)
        
        landSpace1.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.4)
        self.view.addSubview(landSpace1)
        
        landSpace2.backgroundColor = UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 0.4)
        self.view.addSubview(landSpace2)
        
        waterSpace1.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.4)
        self.view.addSubview(waterSpace1)
        
        waterSpace2.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 0.4)
        self.view.addSubview(waterSpace2)
        
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
        

    }
    
    func startTime() {
        time = setUpTimer()
        time.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(SortingViewController.updateTimeImages)), userInfo: nil, repeats: true)
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
        }
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
                if getOurVehicles.allArray[i].isAir {
                    if view.frame.intersects(airSpace.frame) {
                        print("air")
                    } else {
                        returnViewToOrigin(index: i, view: view)
                    }
                } else if getOurVehicles.allArray[i].isWater {
                    if view.frame.intersects(waterSpace1.frame) || view.frame.intersects(waterSpace2.frame) {
                        print("water")
                    } else {
                        returnViewToOrigin(index: i, view: view)
                    }
                } else if getOurVehicles.allArray[i].isLand {
                    if view.frame.intersects(landSpace1.frame) || view.frame.intersects(landSpace2.frame){
                        print("land")
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

    
    
    func setUpVehicles() {
        for i in 0 ..< getOurVehicles.allArray.count {
            if ourDifficulty.difficulty == "Easy" {
                let singleVehicleImage = UIImageView(frame: CGRect(x:232 + (i * 70), y:75, width: 60, height: 60))
                singleVehicleImage.contentMode = .scaleAspectFit
                singleVehicleImage.image = checkTypeAndReturnImage(vehicle: getOurVehicles.allArray[i])
                singleVehicleImage.isUserInteractionEnabled = true
                singleVehicleImage.addGestureRecognizer(moveImg[i])
                self.view.addSubview(singleVehicleImage)
                originalLocations.append(singleVehicleImage.frame.origin)
            } else if ourDifficulty.difficulty == "Medium" {
                let singleVehicleImage = UIImageView(frame: CGRect(x:162 + (i * 70), y:75, width: 60, height: 60))
                singleVehicleImage.contentMode = .scaleAspectFit
                singleVehicleImage.image = checkTypeAndReturnImage(vehicle: getOurVehicles.allArray[i])
                singleVehicleImage.isUserInteractionEnabled = true
                self.view.addSubview(singleVehicleImage)
            } else if ourDifficulty.difficulty == "Hard"{
                let singleVehicleImage = UIImageView(frame: CGRect(x:92 + (i * 70), y:75, width: 60, height: 60))
                singleVehicleImage.contentMode = .scaleAspectFit
                singleVehicleImage.image = checkTypeAndReturnImage(vehicle: getOurVehicles.allArray[i])
                singleVehicleImage.isUserInteractionEnabled = true
                self.view.addSubview(singleVehicleImage)
                
            }
        }
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
