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
    
    var ourDifficulty = GameAndDifficulty()
    var getOurVehicles = AllVehicles(difficulty: "")
    var time = Time(seconds: 0)
    
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
        
        startTime()
        addBackgroundImage()
        addSortingBar()
        timeUI()
        scoreUI()
        setUpVehicles()

        // Do any additional setup after loading the view.
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
    
    func setUpVehicles() {
        for i in 0 ..< getOurVehicles.allArray.count {
            if ourDifficulty.difficulty == "Easy" {
                let singleVehicleImage = UIImageView(frame: CGRect(x:232 + (i * 70), y:75, width: 60, height: 60))
                singleVehicleImage.contentMode = .scaleAspectFit
                singleVehicleImage.image = checkTypeAndReturnImage(vehicle: getOurVehicles.allArray[i])
                self.view.addSubview(singleVehicleImage)
            } else if ourDifficulty.difficulty == "Medium" {
                let singleVehicleImage = UIImageView(frame: CGRect(x:162 + (i * 70), y:75, width: 60, height: 60))
                singleVehicleImage.contentMode = .scaleAspectFit
                singleVehicleImage.image = checkTypeAndReturnImage(vehicle: getOurVehicles.allArray[i])
                self.view.addSubview(singleVehicleImage)
            } else if ourDifficulty.difficulty == "Hard"{
                let singleVehicleImage = UIImageView(frame: CGRect(x:92 + (i * 70), y:75, width: 60, height: 60))
                singleVehicleImage.contentMode = .scaleAspectFit
                singleVehicleImage.image = checkTypeAndReturnImage(vehicle: getOurVehicles.allArray[i])
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
