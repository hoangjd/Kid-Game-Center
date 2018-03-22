//
//  AllVehicles.swift
//  Kids_Joy_Center
//
//  Created by Joseph Hoang on 3/21/18.
//  Copyright © 2018 Joe Hoang. All rights reserved.
//

import Foundation
import UIKit

class AllVehicles {
    var allArray = [SingleVehicle]()
    var airArray = [Int](repeatElement(0, count: 5))
    var waterArray = [Int](repeatElement(0, count: 5))
    var landArray = [Int](repeatElement(0, count: 5))
    var difficulty: String
    
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
    
    init(difficulty: String){
        self.difficulty = difficulty
        pickAmountFromEachCategory()
        randomlyChooseFromEachCategory()
        print(airArray)
        print(waterArray)
        print(landArray)
    }
    
    
    func pickAmountFromEachCategory() {
        var numberOfItems: Int = 0
        var arrayOf3Types: [Int] = [Int](repeatElement(0, count: 3))
        if difficulty == "Easy" {
            numberOfItems = 8
        } else if difficulty == "Medium" {
            numberOfItems = 10
        } else if difficulty == "Hard" {
            numberOfItems = 12
        } else {
            return
        }
        
        for _ in 0 ..< numberOfItems {
            var rand = Int(arc4random_uniform(3))
            if arrayOf3Types[rand] < 5 {
                arrayOf3Types[rand] += 1
                allArray.append(identifyVehicles(randItem: rand))
            } else {
                while arrayOf3Types[rand] == 5 {
                    rand = Int(arc4random_uniform(3))
                }
                arrayOf3Types[rand] += 1
                allArray.append(identifyVehicles(randItem: rand))
            }
        }
    }
    
    func identifyVehicles(randItem: Int) -> SingleVehicle {
        let vehicle = SingleVehicle()
        if randItem == 0 {
            vehicle.isAir = true
        } else if randItem == 1 {
            vehicle.isWater = true
        } else {
            vehicle.isLand = true
        }
        return vehicle
    }
    
    func randomlyChooseFromEachCategory() {
        for vehicle in allArray {
            if vehicle.isAir {
                randomNoRepeats(vehicle: vehicle, array: &airArray)
            } else if vehicle.isWater {
                randomNoRepeats(vehicle: vehicle, array: &waterArray)
            } else if vehicle.isLand {
                randomNoRepeats(vehicle: vehicle, array: &landArray)
            }
        }
    }
    
    func randomNoRepeats(vehicle: SingleVehicle, array: inout [Int]) {
        var rand = Int(arc4random_uniform(5))
        if array[rand] == 0 {
            array[rand] += 1
            vehicle.typeIdentifier = rand
        } else {
            while array[rand] == 1 {
                rand = Int(arc4random_uniform(5))
            }
            array[rand] += 1
            vehicle.typeIdentifier = rand
        }
    }
    

    

}
