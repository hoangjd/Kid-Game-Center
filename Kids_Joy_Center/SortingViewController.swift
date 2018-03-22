//
//  SortingViewController.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/21/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import UIKit

class SortingViewController: UIViewController {
    
    let minutes = UIImageView(frame: CGRect(x:140, y:720, width: 20, height: 30))
    let seconds = UIImageView(frame: CGRect(x:180, y:720, width: 20, height: 30))
    let seconds2 = UIImageView(frame: CGRect(x:210, y:720, width: 20, height: 30))
    let score1Img = UIImageView(frame: CGRect(x:895, y:720, width: 20, height: 30))
    let score2Img = UIImageView(frame: CGRect(x:925, y:720, width: 20, height: 30))
    
    var ourDifficulty = GameAndDifficulty()
 //   var getOurVehicles = AllVehicles(difficulty: "")
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var getOurVehicles = AllVehicles(difficulty: ourDifficulty.difficulty!)
        
        
        addBackgroundImage()
        addSortingBar()
        timeUI()
        scoreUI()

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
    }
    
    func scoreUI(){
        let scoreSpace = UIImageView(frame: CGRect(x:775, y: 720, width: 80, height: 30))
        scoreSpace.contentMode = .scaleAspectFill
        scoreSpace.image = UIImage(named:"score")
        self.view.addSubview(scoreSpace)
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
