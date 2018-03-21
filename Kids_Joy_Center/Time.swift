//
//  Time.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/21/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import Foundation
import UIKit

class Time {
    var timer = Timer()
    var gameType: String
    var seconds: Int
    var minImg: UIImage?
    var secondImg: UIImage?
    var second2Img: UIImage?
    let timeImageArray: [UIImage] = [
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
    init(seconds: Int, gameType: String){
        self.seconds = seconds
        self.gameType = gameType
    }
    
    func updateImages(time: TimeInterval){
        let minutes = Int(time)/60 % 60
        let sec = Int(time) % 60 / 10
        let sec2 = Int(time) % 60 % 10
        
        self.minImg = timeImageArray[minutes]
        self.secondImg = timeImageArray[sec]
        self.second2Img = timeImageArray[sec2]
    }
    
//    func startTime() {
//        if gameType == "Memory" {
//            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MemoryViewController.updateTimeImages)), userInfo: nil, repeats: true)
//        }
//    }
    
    func formatedTime(time:TimeInterval) -> String {
        let minutes = Int(time)/60 % 60
        let seconds = Int(time) % 60
        return String(format:"%01i:%02i",minutes,seconds)
        
    }
    
//    @objc func updateTime() -> Int{
//        //     print (seconds)
//        print(formatedTime(time: TimeInterval(self.seconds)))
//        if self.seconds > 0{
//            updateImages(time: TimeInterval(self.seconds))
//            self.seconds = self.seconds - 1
//            return self.seconds
//        } else {
//            updateImages(time: TimeInterval(self.seconds))
//            //      self.timer.invalidate()
//            return 0
//        }
//    }
}
